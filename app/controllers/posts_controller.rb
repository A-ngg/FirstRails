class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /posts
  def index
    @posts = Post.includes(:user, :comments).all
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments   # ✅ This ensures @comments is not nil
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    puts "DEBUG PARAMS: #{params.inspect}"  # Add this line to check incoming params

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Authorize user
  def authorize_user!
    redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:title, :content)
  end
end
