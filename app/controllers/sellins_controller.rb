require 'open-uri'
class SellinsController < ApplicationController
  before_action :set_sellin, only: [:update, :show]
  before_action :authenticate_user

  # GET /sellins/list
  def index
    @page = params.fetch(:p).to_i
    @total = Sellin.count
    @sellins = Sellin.order(updated_at: :desc).page(@page).per(1000)
    if @sellins.present?
      render :index, status: :ok
    else
      @message = "no sellin found"
      render :error, status: :not_found
    end
  end

  def search_service_tag
    @total = Sellin.count
    @sellins = Sellin.where('service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ? OR service_tag LIKE ?', "%#{params[:q]}%", "#{params[:q]}%", "%#{params[:q]}", params[:q])
    render :index, status: :ok
  end

  def bulk_search_service_tag
    @total = Sellin.count
    search = params.fetch(:q).to_s.split(/\s*,\s*/)
    @sellins = Sellin.where(service_tag: search)
    render :index, status: :ok
  end

  # # GET /sellins/:id
  # def show
  # end

  # POST /sellins/create
  # def create
  #   @sellin = Sellin.new(sellin_params)
  #
  #   if @sellin.save
  #     render :show, status: :created, location: @sellin
  #   else
  #     render json: @sellin.errors, status: :unprocessable_entity
  #   end
  # end

  def input_sellin_from_csv
    csv_file = CsvUploader.new
    csv_file.store!(params.fetch(:csv))
    csv_data = SmarterCSV.process(open(csv_file.url), {value_converters: {transaction_date: DateConverter}, col_sep: ';'})
    if csv_data.present?
      saved_data = []

      csv_data.each do |data|
        sellins_tmp = Sellin.new(data)
        sellins_tmp.csv_ref = csv_file.url
        saved_data << sellins_tmp
      end
      begin
        @sellins = Sellin.import(saved_data)
        # @success_input = Sellin.where(id: @sellins.ids)
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

  def sellin_csv_export
    year_from = params.fetch(:quarter_year_from, nil).to_i
    year_to = params.fetch(:quarter_year_to, nil).to_i
    quarter_from = params.fetch(:quarter_from, nil).to_i
    quarter_to = params.fetch(:quarter_to, nil).to_i
    week_from = params.fetch(:quarter_week_from, nil).to_i
    week_to = params.fetch(:quarter_week_to, nil).to_i
    @export = Sellin.where(quarter_year: (year_from..year_to)).where(quarter: (quarter_from..quarter_to)).where(quarter_week: (week_from..week_to)).find_each(batch_size: 10000).to_a.flatten
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at, :csv_ref]), type: 'text/csv: charset=utf-8; header=present', filename: "report-" + Time.now.to_datetime.to_s + ".csv")
  end

  # PATCH/PUT /sellins/:id
  def update
    if @sellin.update(sellin_params)
      render :show, status: :ok
    else
      render json: @sellin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sellins/:id
  def destroy
    @sellin.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sellin
    @sellin = Sellin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sellin_params
    params.permit(:service_tag, :quarter_year, :quarter, :quarter_week, :item_type, :part_number, :product_type, :product_name, :source_store, :target_store, :transaction_date)
    sellin_data = {
        service_tag: params.fetch(:service_tag),
        quarter_year: params.fetch(:quarter_year).to_i,
        quarter: params.fetch(:quarter).to_i,
        quarter_week: params.fetch(:quarter_week).to_i,
        item_type: params.fetch(:item_type).to_i,
        part_number: params.fetch(:part_number, nil).to_s,
        product_type: params.fetch(:product_type, nil).to_s,
        product_name: params.fetch(:product_name, nil).to_s,
        source_store: params.fetch(:source_store).to_i,
        target_store: params.fetch(:target_store).to_i
    }
  end
end
