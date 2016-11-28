class PosmsController < ApplicationController
  before_action :set_posm, only: [:show, :update, :destroy]

  # GET /posms
  # GET /posms.json
  def index
    @posms = Posm.all
  end

  # GET /posms/1
  # GET /posms/1.json
  def show
  end

  # POST /posms
  # POST /posms.json
  def create
    @posm = Posm.new(posm_params)

    if @posm.save
      render :show, status: :created
    else
      @message = "cant save posm"
      render :error, status: :internal_server_error
    end
  end

  # PATCH/PUT /posms/1
  # PATCH/PUT /posms/1.json
  def update
    if @posm.update(posm_params)
      render :show, status: :ok
    else
      render json: @posm.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posms/1
  # DELETE /posms/1.json
  def destroy
    @posm.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_posm
    @posm = Posm.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def posm_params
    params.permit(:name, :quantity)
    issue_data = {
        name: params.fetch(:name).to_s,
        quantity: params.fetch(:quantity).to_i
    }
  end
end
