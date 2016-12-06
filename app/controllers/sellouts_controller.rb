class SelloutsController < ApplicationController
  # before_action :set_sellout, only: [:show, :update, :destroy]
  before_action :authenticate_user


  # GET /sellouts
  # GET /sellouts.json
  def index
    @sellouts = Sellout.all
    if @sellouts.present?
      render :index, status: :ok
    else
      @message = "no sellout found"
      render :error, status: :not_found
    end
  end

  # GET /sellouts/1
  # GET /sellouts/1.json
  def show
  end

  # POST /sellouts
  # POST /sellouts.json
  def create
    inventory_data = Inventory.where(service_tag: params.fetch(:service_tag, nil).to_s).first
    sellin_data = Sellin.where(service_tag: params.fetch(:service_tag, nil).to_s).first
    store_data = Store.find(params.fetch(:store_id, nil).to_i)

    if inventory_data.present? && store_data.present? && sellin_data.present? && store_data == inventory_data.store
      if params.fetch(:proof, nil)
        @sellout = Sellout.new(sellout_params)
        sales_time = Time.now
        @sellout.store = store_data
        @sellout.inventory = inventory_data
        @sellout.user = current_user
        if params[:sold_by].present?
          @sellout.sold_by = User.find(params.fetch(:sold_by, nil).to_i)
        else
          @sellout.sold_by = current_user
        end
        @sellout.quarter_year = current_quarter_year(sales_time)
        @sellout.quarter = current_quarter_months(sales_time)
        @sellout.quarter_week = current_quarter_week(sales_time)
        begin
          @sellout.save
          inventory_data.status = 1
          inventory_data.save
          render :show, status: :created
        rescue ActiveRecord::RecordNotUnique
          @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 1, solved: false)
          @message = "sellout already inputted"
          render :error, status: :unauthorized
        rescue StandardError => e
          @message = e
          render :error, status: :internal_server_error
        end
      else
        @message = "error processing proof photo"
        render :error, status: :bad_request
      end
    elsif !sellin_data.present?
      @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 0, solved: false)
      @message = "no sellin avaliable on the store for the service tag"
      render :error, status: :not_found
    else
      @conflict_sellout = ConflictedSellout.create(user_id: current_user.id, store_id: store_data.id, service_tag: params.fetch(:service_tag, nil).to_s, cause: 2, solved: false)
      @message = "no inventory avaliable on the store for the service tag"
      render :error, status: :not_found
    end
  end

  def ccc
    manager = Manager.new(name: "manager test")
    manager.channel_area_manager = Manager.find(1)
    render json: manager
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

  def list_conflicted_sellouts
    @conflicts = ConflictedSellout.all
    if @conflicts.present?
      render json: @conflicts, status: :ok
    else
      @message = "no conflict found"
      render :error, status: :not_found
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sellout
    @sellout = Sellout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sellout_params
    params.permit(:service_tag, :price_idr, :price_usd, :proof, :store_id, :sold_by)
    user_data = {
        service_tag: params.fetch(:service_tag).to_s,
        price_idr: params.fetch(:price_idr, 0).to_f,
        price_usd: params.fetch(:price_usd, 0).to_f,
        proof: params.fetch(:proof, nil)
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

end
