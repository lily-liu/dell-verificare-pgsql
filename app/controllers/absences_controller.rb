class AbsencesController < ApplicationController
  before_action :set_absence, only: [:show]
  before_action :authenticate_user

  def index
    @absences = Absence.all
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
    store_data = Store.find_by store_uid: params.fetch(:store_uid, "STR-000")
    if user.present? && store_data.present? && params.fetch(:absence_type) !=nil
      existing_absence_in = Absence.where("created_at > ? AND absence_type = ? AND user_id = ? AND store_id = ?", 2.hour.ago, 1, current_user.id.to_i, store_data.id.to_i).first
      existing_absence_out = Absence.where("created_at > ? AND absence_type = ? AND user_id = ? AND store_id = ?", 2.hour.ago, 2, current_user.id.to_i, store_data.id.to_i).first
      case params.fetch(:absence_type).to_i
        when 2
          if existing_absence_in.present? && !existing_absence_out.present?
            save_absence(user, store_data, absence_params)
          else
            @message = "cant absence out without absence in or absence out multiple times"
            render :error, status: :unauthorized
          end
        when 1
          if !existing_absence_in.present? && !existing_absence_out.present?
            save_absence(user, store_data, absence_params)
          else
            @message = "cant absence in same store multiple times"
            render :error, status: :unauthorized
          end
        else
          save_absence(user, store_data, absence_params)
      end
    else
      @message = "no username match in database or store not recognized"
      render :error, status: :not_found
    end
  end

  def export_absence
    @export = Absence.where(created_at: 1.month.ago)
    send_data(@export.to_a.to_csv, type: 'text/csv', filename: "absence-recap-#{Time.now.to_date}.csv")
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
