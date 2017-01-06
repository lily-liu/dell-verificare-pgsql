class ManagersController < ApplicationController
  before_action :set_manager, only: [:show, :update, :destroy]
  before_action :authenticate_user


  # GET /managers
  # GET /managers.json
  def index
    @managers = Manager.all
    if @managers.present?
      render :index, status: :ok
    else
      @message = "no manager found"
      render :error, status: :not_found
    end
  end

  # GET /managers/1
  # GET /managers/1.json
  def show
  end

  # POST /managers
  # POST /managers.json
  def create
    @manager = Manager.new(manager_params)

    if @manager.save
      render :show, status: :created
    else
      @message = @user.errors
      render :error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /managers/1
  # PATCH/PUT /managers/1.json
  def update
    if @manager.update(manager_params)
      render :show, status: :ok
    else
      @message = @user.errors
      render :error, status: :unprocessable_entity
    end
  end

  # DELETE /managers/1
  # DELETE /managers/1.json
  def destroy
    if @manager.destroy
      render :show, status: :ok
    else
      @message = @user.errors
      render :error, status: :unprocessable_entity
    end
  end

  def managers_csv_export
    @export = Manager.all.to_a
    send_data(@export.to_csv(except: [:created_at, :updated_at, :deleted_at]), type: 'text/csv', filename: "manager-list-#{Time.now.to_date}.csv")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_manager
    @manager = Manager.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def manager_params
    params.permit(:name, :level, :parent_id)
    user_data = {
        level: params.fetch(:level, 0).to_i,
        parent_id: params.fetch(:parent_id, nil),
        name: params.fetch(:name).to_s,
    }
  end
end
