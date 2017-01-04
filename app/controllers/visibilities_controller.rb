require 'open-uri'
class VisibilitiesController < ApplicationController
  # include ActionController::Streaming
  # include Zipline
  before_action :set_visibility, only: [:show, :update, :destroy]
  # before_action :authenticate_user

  # GET /visibilities
  # GET /visibilities.json
  def index
    @visibilities = User.where(level: [2, 3, 4, 5])
    if @visibilities.present?
      render :index, status: :ok
    else
      @message = "no visibility found"
      render :error, status: :not_found
    end
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

  # def list_visibility_view
  #   @user = User.find(params.fetch(:user_id).to_i)
  #   @store = Store.find(params.fetch(:store_id).to_i)
  #   @visibilities = Visibility.where('user_id = ? AND created_at > ?', 1, 1.week.ago).order(:category, :created_at)
  #   @deck = Powerpoint::Presentation.new
  #   ppt_uploader = PptUploader.new
  #
  #   ppt_title = "Report for Store #{@store.name} by #{@user.username}"
  #   ppt_subtitle = Time.now.to_date
  #   @deck.add_intro ppt_title, ppt_subtitle
  #
  #   asd =[]
  #   @visibilities.each do |visibility|
  #     title = "Category: #{visibility.category.humanize}\nOn: #{visibility.created_at.to_date}"
  #     image_path = open(visibility.visibility.url).path
  #     @deck.add_pictorial_slide title, image_path
  #   end
  #   tmp_file = @deck.save("public/uploads/ppt/#{SecureRandom.uuid}.pptx")
  #   if tmp_file.present?
  #     send_file(tmp_file, filename: "#{@user.username}_#{@store.name.parameterize}.pptx", content_type: "application/vnd.openxmlformats-officedocument.presentationml.presentation")
  #   else
  #     @message = "unable to generate presentation file"
  #     render :error, status: :not_found
  #   end
  #   # pdf = WickedPdf.new.pdf_from_string(html)
  #   # send_data(pdf, filename: "#{@user}_#{@store.name}_visibility_report_#{Time.now.to_date}", disposition: 'attachment')
  # end

  def export_zip
    Aws.config.update({credentials: Aws::Credentials.new('AKIAINCAF4JBFYUFPNAA', 'E5Z8ZbZuJqvqLk/6hEoJktQ960WRx92jKpAmd6di')})

    s3 = Aws::S3::Resource.new(region: 'ap-southeast-1')

    bucket = s3.bucket("verificareuploads")

    items = Visibility.where('user_id = ? AND store_id = ? AND created_at > ?', params.fetch(:user_id).to_i, params.fetch(:store_id).to_i, 1.week.ago)

    folder = "uploads/posm_visibility"

    zip_stream = Zip::OutputStream.write_buffer do |zip|

      items.each do |item|

        file_obj = bucket.object("#{folder}/#{item.visibility_identifier}")

        zip.put_next_entry("#{item.id}-#{item.category}-#{item.visibility_identifier}")

        zip.print file_obj.get.body.read
      end
    end
    zip_stream.rewind

    begin
      tempZip = Tempfile.new([SecureRandom.hex(8), '.zip'])
      tempZip.binmode
      tempZip.write zip_stream.read
      tempZip.rewind
      send_data(tempZip.read, type: 'application/zip', filename: "recap-#{Time.now.to_date}.zip")
    ensure
      tempZip.close
      tempZip.unlink
    end

  end

  # def test_zip
  #   # @visibilities = Visibility.where('user_id = ? AND created_at > ?', 1, 1.week.ago).order(:category, :created_at)
  #   visibilities = Visibility.all
  #   files = visibilities.map { |visibility| [visibility.visibility, "#{visibility.visibility.url}.png"] }
  #   zipline(files, 'test.zip')
  # end

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
