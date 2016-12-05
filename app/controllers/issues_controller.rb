class IssuesController < ApplicationController
  before_action :set_issue, only: [:show] #, :update, :destroy]
  before_action :authenticate_user


  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
    if @issues.present?
      render :index, status: :ok
    else
      @message = "no issues found"
      render :error, status: :not_found
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    user = current_user
    if @issue.save
      render :show, status: :created
    else
      @message = @issue.errors
      render :error, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    #params.fetch(:issue, {})
    params.permit(:user, :program_name, :brand_name, :store_name, :campaign_start, :campaign_end, :remark, :photo_name)
    issue_data = {
        user: current_user,
        program_name: params.fetch(:program_name).to_s,
        brand_name: params.fetch(:brand_name).to_s,
        store_name: params.fetch(:store_name).to_s,
        campaign_start: params.fetch(:campaign_start).to_time,
        campaign_end: params.fetch(:campaign_end).to_time,
        remark: params.fetch(:remark).to_s,
        photo_name: params.fetch(:photo_name, nil)
    }
  end

end
