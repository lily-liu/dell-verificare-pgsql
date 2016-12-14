class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /stores
  # GET /stores.json
  def list_stores
    @stores = Store.where("level = ?", 2)
    if @stores.present?
      render :index, status: :ok
    else
      @message = "no store found"
      render :error, status: :not_found
    end
  end

  def list_dealers
    @stores = Store.where("level = ?", 1)
    if @stores.present?
      render :index, status: :ok
    else
      @message = "no store found"
      render :error, status: :not_found
    end
  end

  def list_distributors
    @stores = Store.where("level = ?", 0)
    if @stores.present?
      render :index, status: :ok
    else
      @message = "no store found"
      render :error, status: :not_found
    end
  end

  def stores_csv_export
    @export = Store.all.to_a
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at, :id]), type: 'text/csv: charset=utf-8; header=present', filename: "store-list-#{Time.now.to_date}.csv")
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    @store.city = City.find(params.fetch(:city_id).to_i)

    if @store.save
      render :show, status: :created
    else
      @message = @store.errors
      render :error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    if @store.update(store_update_params)
      render :show, status: :ok
    else
      @message = @store.errors
      render :error, status: :unprocessable_entity
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    if @store.destroy
      render :show, status: :ok
    else
      @message = @store.errors
      render :error, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.permit(:store_uid, :city_id, :name, :level, :phone, :address, :store_building, :email, :store_category, :store_owner)
    store_data = {
        city_id: params.fetch(:city_id, nil).to_i,
        store_uid: params.fetch(:store_uid, nil).to_s,
        name: params.fetch(:name, nil).to_s,
        level: params.fetch(:level, 0).to_i,
        phone: params.fetch(:phone, nil).to_s,
        address: params.fetch(:address, nil).to_s,
        email: params.fetch(:email, nil).to_s,
        store_building: params.fetch(:store_building, nil).to_s,
        store_category: params.fetch(:store_category, nil).to_i,
        store_owner: params.fetch(:store_owner, nil).to_s,
    }
  end

  def store_update_params
    params.permit(:name, :level, :phone, :address, :store_building, :email, :store_owner)
    store_data = {
        city_id: params.fetch(:city_id, nil).to_i,
        name: params.fetch(:name, nil).to_s,
        level: params.fetch(:level, 0).to_i,
        phone: params.fetch(:phone, nil).to_s,
        address: params.fetch(:address, nil).to_s,
        email: params.fetch(:email, nil).to_s,
        store_building: params.fetch(:store_building, nil).to_s,
        store_owner: params.fetch(:store_owner, nil).to_s,
    }
  end
end
