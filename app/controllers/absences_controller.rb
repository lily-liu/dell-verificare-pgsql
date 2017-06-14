class AbsencesController < ApplicationController
  before_action :set_absence, only: [:show]
  # before_action :authenticate_user

  def index
    @page = params.fetch(:p,1).to_i
    @absences = Absence.all.order(created_at: :desc).page(@page).per(1000)
    if @absences.present?
      render :index, status: :ok
    else
      @message = "no absence found"
      render :error, status: :not_found
    end
  end

  def index_non_admin
    @absences = Absence.where(user_id: current_user.id).order(created_at: :desc)
    if @absences.present?
      render :index, status: :ok
    else
      @message = "no absence found"
      render :error, status: :not_found
    end
  end

  # POST /absences
  # POST /absences.json
  def create
    user = current_user
    store_data = Store.find_by store_uid: params.fetch(:store_uid, "STR-000").to_s
    if user.present? && store_data.present? && params.fetch(:absence_type) !=nil
      save_absence(user, store_data, absence_params)
    else
      @message = "no username match in database or store not recognized"
      render :error, status: :not_found
    end
  end

  def export_absence
    export_data = Absence.joins(:store).joins(:user).where('absences.created_at >= ?', 3.month.ago).select('absences.absence_type, absences.remark, absences.created_at, users.name as username, stores.name')
    @export = AbsenceBuilder.build(export_data)
    send_data(@export, type: 'text/csv', filename: "absence-recap-#{Time.now.to_date}.csv")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_absence
    @absence = Absence.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def absence_params
    params.permit(:absence_type, :store_uid, :latitude, :longitude, :remark)
    user_data = {
        absence_type: params.fetch(:absence_type).to_i,
        latitude: params.fetch(:latitude, 0).to_f,
        longitude: params.fetch(:longitude, 0).to_f,
        remark: params.fetch(:remark, nil).to_s
    }
  end

  def save_absence(user, store, params)
    @absence = Absence.new(params)
    @absence.user = user
    @absence.store = store

    if @absence.save
      render :show, status: :created
    else
      @message = "cant save, error on saving"
      render :error, status: :unprocessable_entity
    end
  end

end
