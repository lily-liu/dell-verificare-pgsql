require 'open-uri'
class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /inventories
  # GET /inventories.json
  def index
    @page = params.fetch(:p).to_i
    @inventories = Inventory.where(status: 0).order(updated_at: :desc).page(@page).per(1000)
    @total = Inventory.count
    if @inventories.present?
      render :index, status: :ok
    else
      @message = "no inventory found"
      render :error, status: :not_found
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
  end

  def import_inventory
    csv_file = CsvUploader.new
    csv_file.store!(params.fetch(:csv))
    csv_data = SmarterCSV.process(open(csv_file.url), col_sep: ';')
    if csv_data.present?
      saved_data = []

      csv_data.each do |data|
        inventories_tmp = Inventory.new(data)
        inventories_tmp.csv_ref = csv_file.url
        inventories_tmp.added_by = current_user
        saved_data << inventories_tmp
      end
      begin
        @inventories = Inventory.import(saved_data)
        # @success_input = Inventory.where(id: @inventories.ids)
        render :import, status: :ok
      rescue StandardError => e
        @message = e
        render :error, status: :internal_server_error
      end
    else
      @message = "csv file is empty"
      render :error, status: :internal_server_error
    end
  end

  def inventories_export
    @export = Inventory.where('updated_at > ?', 3.month.ago).to_a
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at, :added_by]), type: 'text/csv', filename: "inventory-list-#{Time.now.to_date}.csv")
  end

  def search_service_tag
    @total = Inventory.count
    @inventories = Inventory.where('service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ?', "%#{params[:q]}%", "#{params[:q]}%", "%#{params[:q]}", params[:q]).where.(status: 0)
    render :index, status: :ok
  end

  def bulk_search_service_tag
    @total = Inventory.count
    search = params.fetch(:q).to_s.split(/\s*,\s*/)
    @inventories = Inventory.where(service_tag: search).where.(status: 0)
    render :index, status: :ok
  end

  # POST /inventories
  # POST /inventories.json
  def create
    sellin_data = Sellin.find_by service_tag: params.fetch(:service_tag, nil).to_s.upcase
    store_data = Store.find(params.fetch(:store_id, nil).to_i)
    if sellin_data.present? && store_data.present?
      @inventory = Inventory.new(inventory_params)
      if params[:transaction_date].present?
        @inventory.transaction_date = params.fetch(:transaction_date).to_time
      else
        @inventory.transaction_date = Time.now
      end
      @inventory.status = 0
      if params[:added_by].present?
        @inventory.user = User.find(params.fetch(:added_by).to_i)
        @inventory.added_by = current_user
      else
        @inventory.user = current_user
      end
      @inventory.sellin = sellin_data
      @inventory.store = store_data
      begin
        @inventory.save
        render :show, status: :created
      rescue ActiveRecord::RecordNotUnique
        @inventory = Inventory.find_by service_tag: params.fetch(:service_tag).to_s.upcase
        @inventory.update(user: current_user, store: store_data, status: 2)
        @conflict_inventory = ConflictedInventory.create!(user: current_user, store: store_data, service_tag: params.fetch(:service_tag, nil).to_s.upcase, cause: :inventory_already_added, solved: !nil)
        render :show, status: :ok
      rescue StandardError => e
        @message = e
        render :error, status: :internal_server_error
      end

    else
      @conflict_inventory = ConflictedInventory.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s.upcase, cause: :no_sellin, solved: !nil)
      @message = "no sellin data for that service tag"
      render :error, status: :not_found
    end

  end

  # PATCH/PUT /inventories/1
  # PATCH/PUT /inventories/1.json
  def update
    if @inventory.update(inventory_params)
      render :show, status: :ok, location: @inventory
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory.destroy
  end

  def inventories_per_cam
    @report_unsorted = Manager.select(:name).joins(users: :inventories).where('inventories.status': 1).group(:name).count
    total_data = Manager.select(:name).joins(users: :inventories).where('inventories.status': 1).count
    @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def inventories_each_cam_per_store
    @report_unsorted = Store.select(:name).joins(inventories: [{user: :manager}]).joins(:inventories).where(managers: {id: params.fetch(:manager_id).to_i}).where('inventories.status': 1).group(:name).count
    total_data = Store.select(:name).joins(inventories: [{user: :manager}]).joins(:inventories).where(managers: {id: params.fetch(:manager_id).to_i}).where('inventories.status': 1).count
    @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inventory_params
    params.permit(:store_id, :service_tag, :added_by)
    product_data = {
        store_id: params.fetch(:store_id, nil).to_i,
        service_tag: params.fetch(:service_tag, nil).to_s.upcase
    }
  end

  def date_filter_range_presence
    if params[:quarter_year_from].present? && params[:quarter_year_to].present? &&params[:quarter_from].present? && params[:quarter_to].present? && params[:quarter_week_from].present? && params[:quarter_week_to].present?
      return true
    else
      return false
    end
  end

  def get_date_filter_range
    @year_from = params.fetch(:quarter_year_from, Time.now.year).to_i
    @year_to = params.fetch(:quarter_year_to, Time.now.year).to_i
    @quarter_from = params.fetch(:quarter_from, 1).to_i
    @quarter_to = params.fetch(:quarter_to, 1).to_i
    @week_from = params.fetch(:quarter_week_from, 1).to_i
    @week_to = params.fetch(:quarter_week_to, 1).to_i
  end
end
