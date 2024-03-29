class PosmStoreInventoriesController < ApplicationController
  before_action :set_posm_store_inventory, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /posm_store_inventories
  # GET /posm_store_inventories.json
  def index
    @posm_store_inventories = PosmStoreInventory.all.order(created_at: :desc)
    if @posm_store_inventories.present?
      render :index, status: :ok
    else
      @message = "no posm found"
      render :error, status: :not_found
    end
  end

  # GET /posm_store_inventories/1
  # GET /posm_store_inventories/1.json
  def show
  end

  # POST /posm_store_inventories
  # POST /posm_store_inventories.json
  def create
    @posm_store_inventory = PosmStoreInventory.new(posm_store_inventory_params)
    posm_data = Posm.where('id = ? AND quantity > ?', params.fetch(:posm_id).to_i, 0).first
    store_data = Store.find(params.fetch(:store_id).to_i)

    if posm_data.present? && store_data.present?
      @posm_store_inventory.store = store_data
      @posm_store_inventory.posm = posm_data
      @posm_store_inventory.user = current_user

      @posm_store_inventory.transaction do
        if @posm_store_inventory.save
          posm_data.update(quantity: posm_data.quantity - params.fetch(:quantity).to_i)
          render :show, status: :created
        else
          @message = @posm_store_inventory.errors
          render :error, status: :unprocessable_entity
        end
      end
    else
      @message = "store or posm not available on db"
      render :error, status: :not_found
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

  def posm_inventory_csv_export
    @export = PosmStoreInventory.all.to_a
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at]), type: 'text/csv', filename: "store-list-#{Time.now.to_date}.csv")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_posm_store_inventory
    @posm_store_inventory = PosmStoreInventory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def posm_store_inventory_params
    params.permit(:posm_id, :quantity, :store_id, :visibility)
    issue_data = {
        quantity: params.fetch(:quantity).to_i,
        visibility: params.fetch(:visibility)
    }
  end
end
