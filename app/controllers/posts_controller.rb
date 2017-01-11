class PostsController < ApplicationController
  before_action :set_post, only: [:show] #, :update, :destroy]
  before_action :authenticate_user

  # GET /posts   => Index Post
  def index
    @posts = Post.where(:level => 0)
    if @posts.present?
      render :index, status: :ok
    else
      @message = "no post found"
      render :error, status: :not_found
    end
  end

  def index_comments
    @posts = Post.where(:level => 1)
    if @posts.present?
      render :index, status: :ok
    else
      @message = "no post found"
      render :error, status: :not_found
    end
  end

  # GET /posts/:id
  def show
    @post = Post.find(params.fetch(:id, nil))
    render :show, status: :ok
  end

  # POST /posts/:id/create_post
  def create_post
    @post = Post.new(post_params)
    @post.user = current_user
    @post.level = 0

    if @post.save
      @push_response = push_notif(@post)
      render :show, status: :created
    else
      @message = @post.errors
      render :error, status: :unprocessable_entity
    end
  end

  # POST /posts/:id/create_comment
  def create_comment
    @post = Post.new(post_params)
    @post.parent = Post.find(params.fetch(:parent_id))
    @post.user = current_user
    @post.level = 1

    if @post.save
      @push_response = push_notif(@post)
      render :show, status: :created
    else
      @message = @post.errors
      render :error, status: :unprocessable_entity
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # to push notification to android
  def push_notif(post)
    if ENV['ONESIGNAL_APP_ID'].present? && ENV['ONESIGNAL_API_KEY'].present?
      app_id = ENV['ONESIGNAL_APP_ID']
      api_key = ENV['ONESIGNAL_API_KEY']
    else
      app_id = '399b5406-a95c-42d7-9062-19639af66d4f'
      api_key = 'ODIzNzU5M2QtNWMzYi00OWFjLWE3YzUtZmQwN2U2YjgwZDQx'
    end
    params = {
        app_id: app_id,
        headings: {en: post.title},
        contents: {en: post.content},
        data: {status: 'success', message: 'post', data: post},
        included_segments: ['All']
    }
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type' => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{api_key}")
    request.body = params.as_json.to_json
    response = http.request(request)
    return response.body
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.permit(:title, :content, :user, :level, :parent_id)
    post_data = {
        title: params.fetch(:title).to_s,
        content: params.fetch(:content).to_s,
    }
  end
end
