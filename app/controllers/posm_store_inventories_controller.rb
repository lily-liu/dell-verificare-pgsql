class PosmStoreInventoriesController < ApplicationController
  before_action :set_posm_store_inventory, only: [:show, :update, :destroy]

  # GET /posm_store_inventories
  # GET /posm_store_inventories.json
  def index
    @posm_store_inventories = PosmStoreInventory.all
  end

  # GET /posm_store_inventories/1
  # GET /posm_store_inventories/1.json
  def show
  end

  # POST /posm_store_inventories
  # POST /posm_store_inventories.json
  def create
    @posm_store_inventory = PosmStoreInventory.new(posm_store_inventory_params)

    if @posm_store_inventory.save
      render :show, status: :created, location: @posm_store_inventory
    else
      render json: @posm_store_inventory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posm_store_inventories/1
  # PATCH/PUT /posm_store_inventories/1.json
  def update
    if @posm_store_inventory.update(posm_store_inventory_params)
      render :show, status: :ok, location: @posm_store_inventory
    else
      render json: @posm_store_inventory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posm_store_inventories/1
  # DELETE /posm_store_inventories/1.json
  def destroy
    @posm_store_inventory.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posm_store_inventory
      @posm_store_inventory = PosmStoreInventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posm_store_inventory_params
      params.fetch(:posm_store_inventory, {})
    end
end
