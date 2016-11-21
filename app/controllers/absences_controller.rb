class AbsencesController < ApplicationController
  # before_action :set_absence, only: [:show]
  # before_action :authenticate_user

  # POST /absences
  # POST /absences.json
  def create
    user = User.find(params.fetch(:user_id))
    existing_absence_in = Absence.where("created_at > ? AND absence_type = ? AND user_id = ? AND store_id = ?", 2.hour.ago, 1, params.fetch(:user_id), params.fetch(:store_id))
    existing_absence_out = Absence.where("created_at > ? AND absence_type = ? AND user_id = ? AND store_id = ?", 2.hour.ago, 2, params.fetch(:user_id), params.fetch(:store_id))
    if user.present? && params.fetch(:store_id) != nil && params.fetch(:absence_type) !=nil
      case params.fetch(:absence_type)
        when 1
          if existing_absence_in.present? && !existing_absence_out.present?
            save_absence(user, absence_params)
          else
            @message = "cant absence out without absence in or absence out multiple times"
            render :error, status: :unauthorized
          end
        when 2
          if !existing_absence_in.present? && !existing_absence_out.present?
            save_absence(user, absence_params)
          else
            @message = "cant absence in same store multiple times"
            render :error, status: :unauthorized
          end
        else
          save_absence(user, absence_params)
      end
    else
      @message = "no username match in database or store not recognized"
      render :error, status: :not_found
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_absence
    @absence = Absence.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def absence_params
    user_data = {
        absence_type: params.fetch(:absence_type),
        store_id: params.fetch(:store_id),
        latitude: params.fetch(:latitude, 0),
        longitude: params.fetch(:longitude, 0),
        remark: params.fetch(:Remarks)
    }
  end

  def save_absence(user, params)
    @absence = Absence.new(params)

    if @absence.save
      render :show, status: :created
    else
      @message = "cant save, error on saving"
      render :error, status: :unprocessable_entity
    end
  end

end