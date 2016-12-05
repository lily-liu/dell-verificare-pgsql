class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
    if @regions.present?
      render :index, status: :ok
    else
      @message = "no region found"
      render :error, status: :not_found
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(region_params)

    if @region.save
      render :show, status: :created, location: @region
    else
      render json: @region.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    if @region.update(region_params)
      render :show, status: :ok, location: @region
    else
      render json: @region.errors, status: :unprocessable_entity
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_region
    @region = Region.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def region_params
    params.fetch(:region, {})
  end
end
