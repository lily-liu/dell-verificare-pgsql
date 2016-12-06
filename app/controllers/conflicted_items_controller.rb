class ConflictedItemsController < ApplicationController
  before_action :set_conflicted_item, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /conflicted_items
  # GET /conflicted_items.json
  def list_conflicted_inventory
    @conflicted_items = ConflictedInventory.where(solved: false)
    if @conflicted_items.present?
      render :index, status: :ok
    else
      @message = "no conflict found"
      render :error, status: :not_found
    end
  end

  def list_conflicted_sellouts
    @conflicted_items = ConflictedSellout.where(solved: false)
    if @conflicted_items.present?
      render :index, status: :ok
    else
      @message = "no conflict found"
      render :error, status: :not_found
    end
  end

  # GET /conflicted_items/1
  # GET /conflicted_items/1.json
  def show
  end

  # POST /conflicted_items
  # POST /conflicted_items.json
  def create
    @conflicted_item = ConflictedItem.new(conflicted_item_params)

    if @conflicted_item.save
      render :show, status: :created, location: @conflicted_item
    else
      render json: @conflicted_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conflicted_items/1
  # PATCH/PUT /conflicted_items/1.json
  def update
    if @conflicted_item.update(conflicted_item_params)
      render :show, status: :ok, location: @conflicted_item
    else
      render json: @conflicted_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conflicted_items/1
  # DELETE /conflicted_items/1.json
  def destroy
    @conflicted_item.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conflicted_item
    @conflicted_item = ConflictedItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conflicted_item_params
    params.fetch(:conflicted_item, {})
  end
end
