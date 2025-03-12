class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:edit, :update, :destroy, :show]

    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
      end
    
      def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.update(comment_params)
          redirect_to post_path(@post), notice: "Comment has been updated."
        else
          render 'edit'
        end
      end
  
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
      
        if user_signed_in? # Ensure Devise or authentication is used
          @comment.user = current_user
        end
      
        if @comment.save
          redirect_to @post, notice: "Comment posted successfully!"
        else
          redirect_to @post, alert: "Error posting comment."
        end
    end
  
    def show
      @comment = @post.comments.find(params[:id])
    end
  
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), notice: "Comment deleted successfully."
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = @post.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  