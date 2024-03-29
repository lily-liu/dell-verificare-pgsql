require 'open-uri'
class SelloutsController < ApplicationController
  before_action :set_sellout, only: [:show, :update, :destroy]
  before_action :authenticate_user


  # GET /sellouts
  # GET /sellouts.json
  def index
    @page = params.fetch(:p).to_i
    @sellouts = Sellout.order(updated_at: :desc).page(@page).per(1000)
    @total = Sellout.count
    if @sellouts.present?
      render :index, status: :ok
    else
      @message = "no sellout found"
      render :error, status: :not_found
    end
  end

  def index_per_user
    @page = params.fetch(:p).to_i
    @sellouts = Sellout.where(user_id: current_user.id).order(updated_at: :desc).page(@page).per(1000)
    @total = Sellout.count
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
    inventory_data = Inventory.where(service_tag: params.fetch(:service_tag, nil).to_s.upcase).first
    sellin_data = Sellin.where(service_tag: params.fetch(:service_tag, nil).to_s.upcase).first
    store_data = Store.find(params.fetch(:store_id, nil).to_i)

    if inventory_data.present? && store_data.present? && sellin_data.present?
      if params.fetch(:proof, nil)
        @sellout = Sellout.new(sellout_params)
        if params[:sales_date].present?
          sales_time = params.fetch(:sales_date).to_time
        else
          sales_time = Time.now
        end
        @sellout.store = store_data
        @sellout.inventory = inventory_data
        if params[:added_by].present?
          @sellout.user = User.find(params.fetch(:added_by).to_i)
          @sellout.added_by = current_user
        else
          @sellout.user = current_user
        end
        @sellout.sales_date = sales_time
        @sellout.quarter_year = current_quarter_year(sales_time)
        @sellout.quarter = current_quarter_months(sales_time)
        @sellout.quarter_week = current_quarter_week(sales_time)
        begin
          Sellout.transaction do
            @sellout.save
            inventory_data.status = 1
            inventory_data.save
            render :show, status: :created
          end
        rescue ActiveRecord::RecordNotUnique
          @conflict_sellout = ConflictedSellout.create!(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s.upcase, cause: 1, solved: !nil)
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
      @conflict_sellout = ConflictedSellout.create!(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s.upcase, cause: 0, solved: !nil)
      @message = "no sellin avaliable on the store for the service tag"
      render :error, status: :not_found
    else
      @conflict_sellout = ConflictedSellout.create!(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s.upcase, cause: 2, solved: !nil)
      @message = "inventory store and sellout store is different"
      render :error, status: :not_found
    end
  end

  def import_sellout
    csv_file = CsvUploader.new
    csv_file.store!(params.fetch(:csv))
    csv_data = SmarterCSV.process(open(csv_file.url), {value_converters: {sales_date: DateConverter}, col_sep: ';'})


    if csv_data.present?
      saved_data = []

      csv_data.each do |data|
        sellouts_tmp = Sellout.new(data)
        sellouts_tmp.csv_ref = csv_file.url
        sellouts_tmp.added_by = current_user
        sellouts_tmp.quarter_year = current_quarter_year(sales_time)
        sellouts_tmp.quarter = current_quarter_months(sales_time)
        sellouts_tmp.quarter_week = current_quarter_week(sales_time)
        sellouts_tmp.price_idr = 0
        sellouts_tmp.price_usd = 0
        saved_data << sellouts_tmp
      end

      begin
        @sellouts = Sellout.import!(saved_data)
        @success_input = Sellout.where(id: @sellouts.ids)
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

  def export_sellout
    get_date_filter_range
    if date_filter_range_presence == true
      @export = Sellout.where(quarter_year: (@year_from..@year_to)).where(quarter: (@quarter_from..@quarter_to)).where(quarter_week: (@week_from..@week_to)).to_a
    else
      @export = Sellout.where('updated_at > ?', 3.month.ago).to_a
    end
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at, :proof, :price_idr, :price_usd, :added_by]), type: 'text/csv', filename: "sellout-list-#{Time.now.to_date}.csv")
  end

  def search_service_tag
    @total = Sellout.count
    @sellouts = Sellout.where('service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ?', "%#{params[:q]}%", "#{params[:q]}%", "%#{params[:q]}", params[:q])
    render :index, status: :ok
  end

  def bulk_search_service_tag
    @total = Sellout.count
    search = params.fetch(:q).to_s.split(/\s*,\s*/)
    @sellouts = Sellout.where(service_tag: search)
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

  # def sellouts_each_cam_per_store
  #   @report = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).group(:name).count
  #   render :report, status: :ok
  # end
  #
  # def sellouts_per_cam
  #   @report = Manager.select(:name).joins(users: :sellouts).group(:name).count
  #   render :report, status: :ok
  # end
  #
  # def sellouts_per_region
  #   @report = Region.select(:name).joins(cities: [{stores: :sellouts}]).group(:name).count
  #   render :report, status: :ok
  # end
  #
  # def sellouts_each_store_per_region
  #   @report = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).group(:name).count
  #   render :report, status: :ok
  # end

  def sellout_each_sku_per_cam
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(user: :manager).where(managers: {id: params.fetch(:manager_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group('sellins.product_type').count
      total_data = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(user: :manager).where(managers: {id: params.fetch(:manager_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(user: :manager).where(managers: {id: params.fetch(:manager_id).to_i}).group('sellins.product_type').count
      total_data = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(user: :manager).where(managers: {id: params.fetch(:manager_id).to_i}).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellout_each_sku_per_region
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(store: [{city: :region}]).where(regions: {id: params.fetch(:region_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group('sellins.product_type').count
      total_data = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(store: [{city: :region}]).where(regions: {id: params.fetch(:region_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(store: [{city: :region}]).where(regions: {id: params.fetch(:region_id).to_i}).group('sellins.product_type').count
      total_data = Sellout.select('sellins.product_type').joins(inventory: :sellin).joins(store: [{city: :region}]).where(regions: {id: params.fetch(:region_id).to_i}).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_each_cam_per_store
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:name).count
      total_data = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).group(:name).count
      total_data = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_cam
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Manager.select(:name).joins(users: :sellouts).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:name).count
      total_data = Manager.select(:name).joins(users: :sellouts).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Manager.select(:name).joins(users: :sellouts).group(:name).count
      total_data = Manager.select(:name).joins(users: :sellouts).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_cam_monthly
    year = params.fetch(:year, Date.today.year).to_i
    month_start = Date.new(year, params.fetch(:month, Time.now.month).to_i)
    month_end = month_start.end_of_month
    @report_unsorted = Manager.select(:name).joins(users: :sellouts).where('sellouts.updated_at': (month_start..month_end)).group(:name).count('sellouts.id')
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_region_monthly
    year = params.fetch(:year, Date.today.year).to_i
    month_start = Date.new(year, params.fetch(:month, Time.now.month).to_i)
    month_end = month_start.end_of_month
    @report_unsorted = Region.select(:name).joins(cities: [{stores: :sellouts}]).where('sellouts.updated_at': (month_start..month_end)).group(:name).count('sellouts.id')
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_region
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Region.select(:name).joins(cities: [{stores: :sellouts}]).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:name).count
      total_data = Region.select(:name).joins(cities: [{stores: :sellouts}]).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Region.select(:name).joins(cities: [{stores: :sellouts}]).group(:name).count
      total_data = Region.select(:name).joins(cities: [{stores: :sellouts}]).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_each_store_per_region
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:name).count
      total_data = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).group(:name).count
      total_data = Store.select(:name).joins(:sellouts).joins(city: :region).where(regions: {id: params.fetch(:region_id).to_i}).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_sku
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:product_type).order(product_type: :desc).count
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).group(:product_type).count
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_sku_best10
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:product_type).order("count(product_type) DESC").limit(10).count('product_type')
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).group(:product_type).order("count(product_type) DESC").limit(10).count('product_type')
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellouts_per_sku_worst10
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).group(:product_type).order("count(product_type) ASC").limit(10).count('product_type')
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellin.select(:product_type).joins(inventory: :sellout).group(:product_type).order("count(product_type) ASC").limit(10).count('product_type')
      total_data = Sellin.select(:product_type).joins(inventory: :sellout).count
    end
    # @report_unsorted[:total] = total_data
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end
  
  def sellouts_sku_per_price_category
    filter = SkuFilter.where(price_category: params.fetch(:price_category)).pluck('sku');
    get_date_filter_range
    if date_filter_range_presence == true
      @report_unsorted = Sellin.select(:product_name).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).where(product_name: filter).group(:product_name).order(product_name: :desc).count
      total_data = Sellin.select(:product_name).joins(inventory: :sellout).where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to)).count
    else
      @report_unsorted = Sellin.select(:product_name).joins(inventory: :sellout).where(product_name: filter).group(:product_name).order(product_name: :desc).count
      total_data = Sellin.select(:product_name).joins(inventory: :sellout).count
    end
    @report = @report_unsorted.sort_by { |k, v| v }.reverse.to_h
    render :report, status: :ok
  end

  def sellout_report_export_csv
    get_date_filter_range
    @export = Sellout.joins([:store, {user: :manager}])
                  .joins(store: [{city: :region}])
                  .joins(inventory: :sellin)
                  .where('sellouts.quarter_year': (@year_from..@year_to)).where('sellouts.quarter': (@quarter_from..@quarter_to)).where('sellouts.quarter_week': (@week_from..@week_to))
                  .select('sellouts.created_at AS transaction_date, stores.store_uid, stores.name AS store_name, stores.store_category, stores.store_building AS building_name, stores.address AS store_address, stores.phone AS store_phone, stores.email AS store_email, stores.store_owner, managers.name AS cam_name, users.name AS pic_name, users.level AS user_level, regions.name AS region_name, regions.position AS region, cities.name AS city_name, sellins.service_tag, sellins.part_number, sellins.product_type, sellins.product_name, sellins.source_store AS distributor, sellins.target_store AS master_dealer, sellouts.quarter_year, sellouts.quarter, sellouts.quarter_week')
    csv_data = ReportBuilder.build(@export)
    send_data(csv_data, type: 'text/csv', filename: "report-sellouts-#{Time.now.to_date}.csv")
  end

  # def export_sellouts_each_cam_per_store
  #   @report = Store.select(:name).joins(sellouts: [{user: :manager}]).joins(:sellouts).where(managers: {id: params.fetch(:manager_id).to_i}).group(:name).count
  #   send_data(@report.to_a.to_csv, type: 'text/csv', filename: "recap-sellouts-per-store-cam-#{Time.now.to_date}.csv")
  # end
  #
  # def export_sellouts_per_cam
  #   @report = Manager.select(:name).joins(users: :sellouts).group(:name).count
  #   send_data(@report.to_a.to_csv, type: 'text/csv', filename: "recap-sellouts-per-cam-#{Time.now.to_date}.csv")
  # end
  #
  # def export_sellouts_per_region
  #   @report = Region.select(:name).joins(cities: [{stores: :sellouts}]).group(:name).count
  #   send_data(@report.to_csv, type: 'text/csv', filename: "recap-sellouts-per-region-#{Time.now.to_date}.csv")
  # end
  #
  # def export_sellouts_each_store_per_region
  #   @report = Region.select(:name).joins(cities: [{stores: :sellouts}]).group(:name).count
  #   send_data(@report.to_a.to_csv, type: 'text/csv', filename: "recap-sellouts-per-store-region-#{Time.now.to_date}.csv")
  # end
  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sellout
    @sellout = Sellout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sellout_params
    params.permit(:service_tag, :price_idr, :price_usd, :proof, :store_id, :sold_by, :region_id, :manager_id, :added_by)
    user_data = {
        service_tag: params.fetch(:service_tag).to_s.upcase,
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
    quarters.index(quarters[(date.month - 1) / 3]) + 1
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
