class SelloutsController < ApplicationController
  # before_action :set_sellout, only: [:show, :update, :destroy]
  before_action :authenticate_user


  # GET /sellouts
  # GET /sellouts.json
  def index
    @sellouts = Sellout.all
  end

  # GET /sellouts/1
  # GET /sellouts/1.json
  def show
  end

  # POST /sellouts
  # POST /sellouts.json
  def create
    inventory_data = Inventory.find_by service_tag: params.fetch(:service_tag)
    store_data = Store.find(params.fetch(:store_id))
    photo_proof = params.fetch(:proof, nil)

    if inventory_data.present? && store_data.present?
      if photo_proof != nil
        @sellout = Sellout.new(sellout_params)
        sales_time = Time.now

        @sellout.store = store_data
        @sellout.inventory = inventory_data
        @sellout.user = current_user
        @sellout.quarter_year = current_quarter_year(sales_time)
        @sellout.quarter = current_quarter_months(sales_time)
        @sellout.quarter_week = current_quarter_week(sales_time)
        if upload_photo(photo_proof, params.fetch(:service_tag))
          if @sellout.save
            render :show, status: :created
          else
            render json: @sellout.errors, status: :unprocessable_entity
          end
        else
          @message = "no photo for sellout"
          render :error, status: :bad_request
        end
      else
        @message = "error uploading photo for sellout"
        render :error, status: :unprocessable_entity
      end

    else
      @message = "no sellin for the service tag"
      render :error, status: :bad_request
    end
  end

  # PATCH/PUT /sellouts/1
  # PATCH/PUT /sellouts/1.json
  def update
    if @sellout.update(sellout_params)
      render :show, status: :ok, location: @sellout
    else
      render json: @sellout.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sellouts/1
  # DELETE /sellouts/1.json
  def destroy
    @sellout.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sellout
    @sellout = Sellout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sellout_params
    params.permit(:service_tag, :price_idr, :price_usd, :proof, :store_id)
    user_data = {
        service_tag: params.fetch(:service_tag).to_s,
        price_idr: params.fetch(:price_idr, 0).to_f,
        price_usd: params.fetch(:price_usd, 0).to_f
    }
  end

  def current_quarter_months(date)
    quarters = [[2, 3, 4], [5, 6, 7], [8, 9, 10], [11, 12, 1]]
    quarters.index(quarters[(date.month - 1) / 3])
  end

  def current_quarter_year(date)
    if date.month == 1
      year = date.year
    else
      year = date.year + 1
    end
  end

  # cant find any better solution to this weird problem
  # this function is to get week of current quarter
  # this function is part of legacy system
  def current_quarter_week(date)
    ((((date.to_i - 7171200)/86400) / 7).round % 13) + 1
  end

  # save photo for uploading
  def upload_photo(proof_image, filename)
    uploader = PhotoUploader.new
    uploader.setname(filename)
    uploader.setstore("uploads/proof")
    uploader.store!(proof_image)
  end

end
