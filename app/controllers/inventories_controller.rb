class InventoriesController < ApplicationController
  # before_action :set_inventory, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.all
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
    csv_data = SmarterCSV.process("public#{csv_file.url}")
    if csv_data.present?
      saved_data = []

      csv_data.each do |data|
        inventories_tmp = Inventory.new(data)
        inventories_tmp.csv_ref = csv_file.url
        inventories_tmp.added_by = current_user
        saved_data << inventories_tmp
      end

      @inventories = Inventory.import(saved_data)
      @success_input = Inventory.where(id: @inventories.ids)
      render :import, status: :ok
    else
      @message = "csv file is empty"
      render :error, status: :internal_server_error
    end
  end

  def inventories_export
    @export = Inventory.where(updated_at: 1.week.ago)
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at]), type: 'text/csv', filename: "inventory-list-#{Time.now.to_date}.csv")
  end

  # POST /inventories
  # POST /inventories.json
  def create
    sellin_data = Sellin.find_by service_tag: params.fetch(:service_tag, nil).to_s
    store_data = Store.find(params.fetch(:store_id, nil).to_i)
    inventory_data = Inventory.find_by service_tag: params.fetch(:service_tag, nil).to_s
    if sellin_data.present? && store_data.present?
      @inventory = Inventory.new(inventory_params)
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
        @inventory = inventory_data
        @conflict_inventory = ConflictedInventory.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 1, solved: false)
        @inventory.update(user: current_user, store: store_data, status: 2)
        render :show, status: :ok
      rescue StandardError => e
        @message = e
        render :error, status: :internal_server_error
      end

    else
      @conflict_inventory = ConflictedInventory.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 0, solved: false)
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
    @report = Manager.select(:name).joins(users: :inventories).group(:name).count
    render :report, status: :ok
  end

  def inventories_each_cam_per_store
    @report = Store.select(:name).joins(inventories: [{user: :manager}]).joins(:inventories).where(managers: {id: params.fetch(:manager_id).to_i}).group(:name).count
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
        service_tag: params.fetch(:service_tag, nil).to_s
    }
  end

end
