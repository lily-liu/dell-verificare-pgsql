class VisibilitiesController < ApplicationController
  before_action :set_visibility, only: [:show, :update, :destroy]

  # GET /visibilities
  # GET /visibilities.json
  def index
    @visibilities = Visibility.all
  end

  # GET /visibilities/1
  # GET /visibilities/1.json
  def show
  end

  def list_visibility_per_user_and_store
    store_data = Store.find(params.fetch(:store_id).to_i)
    @visibilities = Visibility.where('user_id = ? AND created_at > ? AND store_id = ?', params.fetch(:user_id).to_i, 1.week.ago, store_data.id)
    if @visibilities.present? && store_data.present?
      render :index, status: :ok
    else
      @message = 'no visibility found'
      render :error, status: :not_found
    end
  end

  def list_visibility_view
    # @user = current_user.username
    @user = User.find(params.fetch(:user_id).to_i)
    @store = Store.find(params.fetch(:store_id).to_i)
    @visibilities = Visibility.where('user_id = ? AND created_at > ?', 1, 1.week.ago).order(:category, :created_at)
    @deck = Powerpoint::Presentation.new

    ppt_title = "Report for Store #{@store.name} by #{@user.username}"
    ppt_subtitle = Time.now.to_date
    @deck.add_intro ppt_title, ppt_subtitle

    @visibilities.each do |visibility|
      title = "Category: #{visibility.category.humanize}\nOn: #{visibility.created_at.to_date}"
      image_path = "public#{visibility.visibility.url}"
      @deck.add_pictorial_slide title, image_path
    end
    tmp_file = @deck.save("public/uploads/ppt/#{SecureRandom.uuid}.pptx")
    if tmp_file.present?
      send_file(tmp_file, filename: "#{@user.username}_#{@store.name.parameterize}.pptx", content_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation")
    else
      @message = "unable to generate presentation file"
      render :error, status: :internal_server_error
    end


    # pdf = WickedPdf.new.pdf_from_string(html)
    # send_data(pdf, filename: "#{@user}_#{@store.name}_visibility_report_#{Time.now.to_date}", disposition: 'attachment')
  end

  # POST /visibilities
  # POST /visibilities.json
  def create
    store_data = Store.find(params.fetch(:store_id).to_i)
    if store_data.present?
      @visibility = Visibility.new(visibility_params)
      @visibility.store = store_data
      @visibility.user = current_user
      if @visibility.save
        render :show, status: :created
      else
        @message = @visibility.errors
        render :error, status: :unprocessable_entity
      end
    else
      @message = "no for visibility"
      render :error, status: :bad_request
    end
  end

  # PATCH/PUT /visibilities/1
  # PATCH/PUT /visibilities/1.json
  def update
    if @visibility.update(visibility_params)
      render :show, status: :ok
    else
      render json: @visibility.errors, status: :unprocessable_entity
    end
  end

  # DELETE /visibilities/1
  # DELETE /visibilities/1.json
  def destroy
    @visibility.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_visibility
    @visibility = Visibility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def visibility_params
    params.permit(:category, :visibility, :remark, :store_id, :user_id)
    issue_data = {
        category: params.fetch(:category).to_i,
        remark: params.fetch(:remark, nil).to_s,
        visibility: params.fetch(:visibility)
    }
  end
end
