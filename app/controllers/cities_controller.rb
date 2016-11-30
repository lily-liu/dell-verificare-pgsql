class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
    if @cities.present?
      render :index, status: :ok
    else
      @message = "no city found"
      render :error, status: :not_found
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    if @city.save
      render :show, status: :created
    else
      @message = @city.errors
      render :error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    if @city.update(city_params)
      render :show, status: :ok
    else
      @message = @city.errors
      render :error, status: :unprocessable_entity
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    if @city.destroy
      render :show, status: :ok
    else
      @message = @store.errors
      render :error, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def city_params
    params.permit(:name, :region_id)
    user_data = {
        name: params.fetch(:name, nil).to_s,
        region_id: params.fetch(:region_id, 0).to_i,
    }
  end

end
