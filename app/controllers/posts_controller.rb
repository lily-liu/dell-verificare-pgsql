class PostsController < ApplicationController
  #before_action :set_post, only: [:show]#, :update, :destroy]
  before_action :authenticate_user

  # GET /posts   => Index Post
  def index
    @posts = Post.where(:level => 0)
  end

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
    @comment = Post.where(:parent_id => @post.id)
  end

  # POST /posts/:id/create_post
  def create_post
    @post = Post.new(post_params)
    @post.user = current_user
    @post.level = 0

    if @post.save
      render :show, status: :created
    else
      @message = 'Cannot save data'
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # POST /posts/:id/create_comment
  def create_comment
    @post = Post.new(post_params)
    @post.post = Post.find(params.fetch(:parent_id))
    @post.user = current_user
    @post.level = 1

    if @post.save
      render :show, status: :created
    else
      @message = 'Cannot save data'
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:title, :content, :user, :level, :parent_id)
      post_data = {
        title: params.fetch(:title).to_s,
        content: params.fetch(:content).to_s,
      }
    end
end
