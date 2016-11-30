class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
    if @stores.present?
      render :index, status: :ok
    else
      @message = "no store found"
      render :error, status: :not_found
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    if @store.save
      render :show, status: :created, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    if @store.update(store_params)
      render :show, status: :ok, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.fetch(:store, {})
    end
end
