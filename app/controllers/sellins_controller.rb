class SellinsController < ApplicationController
  before_action :set_sellin, only: [:update]#[:show, :update, :destroy]

  # GET /sellins/list
  def index
    @sellins = Sellin.all
  end

  # # GET /sellins/:id
  # def show
  # end

  # # POST /sellins/create
  # def create
  #   @sellin = Sellin.new(sellin_params)

  #   if @sellin.save
  #     render :show, status: :created, location: @sellin
  #   else
  #     render json: @sellin.errors, status: :unprocessable_entity
  #   end
  # end

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
      params.permit(:service_tag, :quarter_year, :quarter, :quarter_week, :item_type, :part_number, :product_type, :product_name, :source_store, :target_store) 
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
