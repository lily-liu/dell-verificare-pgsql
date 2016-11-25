class ProductKnowledgesController < ApplicationController
  before_action :set_product_knowledge, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /product_knowledges
  # GET /product_knowledges.json
  def index
    @product_knowledges = ProductKnowledge.all
  end

  # GET /product_knowledges/1
  # GET /product_knowledges/1.json
  def show
  end

  # def download_file
  #   @product_knowledges = ProductKnowledge.find(params[:file_name])
  # end

  # POST /product_knowledges
  # POST /product_knowledges.json
  def create
    @product_knowledge = ProductKnowledge.new(product_knowledge_params)

    if @product_knowledge.save
      render :show, status: :created
    else
      render json: @product_knowledge.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_knowledges/1
  # PATCH/PUT /product_knowledges/1.json
  def update
    if @product_knowledge.update(product_knowledge_params)
      render :show, status: :ok, location: @product_knowledge
    else
      render json: @product_knowledge.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_knowledges/1
  # DELETE /product_knowledges/1.json
  def destroy
    @product_knowledge.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product_knowledge
    @product_knowledge = ProductKnowledge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_knowledge_params
    params.permit(:name, :description, :file_name)
    product_data = {
        name: params.fetch(:name, nil).to_s,
        description: params.fetch(:description, nil).to_s,
        file_name: params.fetch(:file_name, nil)
    }
  end
end
