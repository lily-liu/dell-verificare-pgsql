class SelloutsController < ApplicationController
  before_action :set_sellout, only: [:show, :update, :destroy]
  before_action :authenticate_user


  # GET /sellouts
  # GET /sellouts.json
  def index
    @sellouts = Sellout.all
    if @sellouts.present?
      render :index, status: :ok
    else
      @message = "no sellout found"
      render :error, status: :not_found
    end
  end

  # GET /sellouts/1
  # GET /sellouts/1.json
  def show
  end

  # POST /sellouts
  # POST /sellouts.json
  def create
    inventory_data = Inventory.where(service_tag: params.fetch(:service_tag, nil).to_s).first
    sellin_data = Sellin.where(service_tag: params.fetch(:service_tag, nil).to_s).first
    store_data = Store.find(params.fetch(:store_id, nil).to_i)

    if inventory_data.present? && store_data.present? && sellin_data.present? && store_data == inventory_data.store
      if params.fetch(:proof, nil)
        @sellout = Sellout.new(sellout_params)
        sales_time = Time.now
        @sellout.store = store_data
        @sellout.inventory = inventory_data
        if params[:added_by].present?
          @sellout.user = User.find(params.fetch(:added_by).to_i)
          @sellout.added_by = current_user
        else
          @sellout.user = current_user
        end
        @sellout.quarter_year = current_quarter_year(sales_time)
        @sellout.quarter = current_quarter_months(sales_time)
        @sellout.quarter_week = current_quarter_week(sales_time)
        begin
          @sellout.save
          inventory_data.status = 1
          inventory_data.save
          render :show, status: :created
        rescue ActiveRecord::RecordNotUnique
          @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 1, solved: false)
          @message = "sellout already inputted"
          render :error, status: :unauthorized
        rescue StandardError => e
          @message = e
          render :error, status: :internal_server_error
        end
      else
        @message = "error processing proof photo"
        render :error, status: :bad_request
      end
    elsif !sellin_data.present?
      @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 0, solved: false)
      @message = "no sellin avaliable on the store for the service tag"
      render :error, status: :not_found
    else
      @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 2, solved: false)
      @message = "no inventory avaliable on the store for the service tag"
      render :error, status: :not_found
    end
  end

  def import_sellout
    csv_file = CsvUploader.new
    csv_file.store!(params.fetch(:csv))
    csv_data = SmarterCSV.process("public#{csv_file.url}")


    if csv_data.present?
      # image_default = PhotoUploader.new
      # image_default.store!(File.open(Rails.root + "public/uploads/kona.jpg"))
      # sales_time = Time.now
      # sellouts_tmp = Sellout.new
      # sellouts_tmp.service_tag = "asd"
      # sellouts_tmp.csv_ref = csv_file.url
      # sellouts_tmp.proof = uploader
      # sellouts_tmp.added_by = current_user
      # sellouts_tmp.quarter_year = current_quarter_year(sales_time)
      # sellouts_tmp.quarter = current_quarter_months(sales_time)
      # sellouts_tmp.quarter_week = current_quarter_week(sales_time)
      # sellouts_tmp.price_idr = 0
      # sellouts_tmp.price_usd = 0
      # sellouts_tmp.store_id = 1
      # sellouts_tmp.inventory_id = 1
      # sellouts_tmp.user_id = 1
      #
      # @asd = sellouts_tmp.save!
      # render json: @asd
      saved_data = []
      sales_time = Time.now
      default_image = DefaultImageUploader.new
      default_image.store!(File.open(Rails.root + "public/uploads/default.png"))

      csv_data.each do |data|
        sellouts_tmp = Sellout.new(data)
        sellouts_tmp.csv_ref = csv_file.url
        sellouts_tmp.proof = default_image
        sellouts_tmp.added_by = current_user
        sellouts_tmp.quarter_year = current_quarter_year(sales_time)
        sellouts_tmp.quarter = current_quarter_months(sales_time)
        sellouts_tmp.quarter_week = current_quarter_week(sales_time)
        sellouts_tmp.price_idr = 0
        sellouts_tmp.price_usd = 0
        saved_data << sellouts_tmp
      end

      @sellouts = Sellout.import!(saved_data)
      @success_input = Sellout.where(id: @sellouts.ids)
      render :import, status: :ok
    else
      @message = "csv file is empty"
      render :error, status: :internal_server_error
    end
  end

  def export_sellout
    @export = Sellout.where('updated_at > ?', 1.week.ago).to_a
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at, :proof, :price_idr, :price_usd, :added_by]), type: 'text/csv', filename: "sellout-list-#{Time.now.to_date}.csv")
  end

  def search_service_tag
    @sellouts = Sellout.where('service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ?', "%#{params[:q]}%", "#{params[:q]}%", "%#{params[:q]}", params[:q])
    render :index, status: :ok
  end

  # PATCH/PUT /sellouts/1
  # PATCH/PUT /sellouts/1.json
  def update
    if @sellout.update(update_sellout_params)
      render :show, status: :ok
    else
      @message = "update param is missing"
      render :error, status: :unprocessable_entity
    end
  end

  # DELETE /sellouts/1
  # DELETE /sellouts/1.json
  def destroy
    @sellout.destroy
  end

  def list_conflicted_sellouts
    @conflicts = ConflictedSellout.all
    if @conflicts.present?
      render json: @conflicts, status: :ok
    else
      @message = "no conflict found"
      render :error, status: :not_found
    end
  end

  def sellouts_each_cam_per_store
    @report = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).group(:name).count
    render :report, status: :ok
  end

  def sellouts_per_cam
    @report = Manager.select(:name).joins(users: :sellouts).group(:name).count
    render :report, status: :ok
  end

  def sellouts_per_region
    @report = Region.select(:name).joins(cities: [{stores: :sellouts}]).group(:name).count
    render :report, status: :ok
  end

  def sellouts_each_store_per_region
    @report = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).group(:name).count
    render :report, status: :ok
  end

  def sellout_report_export_csv
    @export = Sellout.joins([:store, {user: :manager}])
                  .joins(store: [{city: :region}])
                  .joins(inventory: :sellin)
                  .select('sellouts.created_at AS transaction_date, stores.store_uid, stores.name AS store_name, stores.store_category, stores.store_building AS building_name, stores.address AS store_address, stores.phone AS store_phone, stores.email AS store_email, stores.store_owner, managers.name AS cam_name, users.name AS pic_name, users.level AS user_level, regions.name AS region_name, regions.position AS region, cities.name AS city_name, sellins.service_tag, sellins.part_number, sellins.product_type, sellins.product_name, sellins.source_store AS distributor, sellins.target_store AS master_dealer, sellouts.quarter_year, sellouts.quarter, sellouts.quarter_week')
    csv_data = ReportBuilder.build(@export)
    # render json: asd, status: :ok
    send_data(csv_data, type: 'text/csv', filename: "report-sellouts-#{Time.now.to_date}.csv")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sellout
    @sellout = Sellout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sellout_params
    params.permit(:service_tag, :price_idr, :price_usd, :proof, :store_id, :sold_by, :region_id, :manager_id, :added_by)
    user_data = {
        service_tag: params.fetch(:service_tag).to_s,
        price_idr: params.fetch(:price_idr, 0).to_f,
        price_usd: params.fetch(:price_usd, 0).to_f,
        proof: params.fetch(:proof, nil)
    }
  end

  def update_sellout_params
    params.permit(:proof)
    user_data = {
        proof: params.fetch(:proof, nil)
    }
  end

  def current_quarter_months(date)
    quarters = [[2, 3, 4], [5, 6, 7], [8, 9, 10], [11, 12, 1]]
    quarters.index(quarters[(date.month - 1) / 3])
  end

  def current_quarter_year(date)
    if date.month == 1
      year = date.year
    else
      year = date.year + 1
    end
  end

  # cant find any better solution to this weird problem
  # this function is to get week of current quarter
  # this function is part of legacy system
  def current_quarter_week(date)
    ((((date.to_i - 7171200)/86400) / 7).round % 13) + 1
  end

end
