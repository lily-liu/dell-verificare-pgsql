class SellKitsController < ApplicationController
  # before_action :set_sell_kit, only: [:show, :update, :destroy]
  # before_action :authenticate_user

  # GET /product_knowledges
  # GET /product_knowledges.json
  def index
    category = params.fetch(category, nil).to_i
    family = params.fetch(family, nil).to_i
    if category.present? && family.present?
      @sell_kits = SellKit.where("category = ? AND family = ?", category, family)
      render :index, status: :ok
    else
      @message = "no category or family match"
      render :error, status: :bad_request
    end
  end

  # GET /product_knowledges/1
  # GET /product_knowledges/1.json
  def show
    @sell_kit = SellKit.find(params.fetch(:id).to_i)
    if @sell_kit.present?
      render :show, status: :ok
    else
      @message = "no item found"
      render :error, status: :not_found
    end
  end

  def download_data
    @sell_kit = SellKit.find(params.fetch(:id).to_i)
    if @sell_kit.present?
      send_data(File.open("#{Rails.root}/public#{@sell_kit.file_name.url}").read.force_encoding('BINARY'), type: 'application/pdf', filename: "sell-kit-#{@sell_kit.category}-#{@sell_kit.name}.pdf")
    else
      @message = "no item found"
      render :error, status: :not_found
    end

  end

  # def download_file
  #   @product_knowledges = ProductKnowledge.find(params[:file_name])
  # end

  # POST /product_knowledges
  # POST /product_knowledges.json
  def create
    @sell_kit = SellKit.new(sell_kit_params)

    if @sell_kit.save
      render :show, status: :created
    else
      @message = @sell_kit.errors
      render :error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_knowledges/1
  # PATCH/PUT /product_knowledges/1.json
  def update
    if @sell_kit.update(product_knowledge_params)
      render :show, status: :ok, location: @sell_kit
    else
      render json: @sell_kit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_knowledges/1
  # DELETE /product_knowledges/1.json
  def destroy
    @sell_kit.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sell_kit
    @sell_kit = SellKit.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sell_kit_params
    params.permit(:name, :description, :file_name, :category, :family)
    product_data = {
        name: params.fetch(:name, nil).to_s,
        description: params.fetch(:description, nil).to_s,
        file_name: params.fetch(:file_name, nil),
        category: params.fetch(:category, nil).to_i,
        family: params.fetch(:family, nil).to_i
    }
  end
end
