class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_commentable

  def index
    @comments = Comment.all
  end
  def show
    @comment = Comment.friendly.find(params[:id])
  end
  def new
    @comment = current_user.comments.build
  end
  def create
    # Determine the commentable object (either a Tweet or a Blog)
    # byebug

    commentable = find_commentable

    # Build the comment associated with the current user and the commentable object
    @comment = current_user.comments.build(comment_params)
    @comment.commentable = commentable

    if @comment.save
      redirect_to polymorphic_path([ commentable ]), notice: "Comment was successfully created."
    else
      puts @comment.errors.full_messages # Debugging line
      render :new
    end
  end
  def edit
    @comment = Comment.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    commentable=@comment.commentable
    @comment.destroy
    redirect_to polymorphic_path([ commentable ]), notice: "Comment was successfully destroyed."
  end
  private
  def set_commentable
    if params[:blog_id]
      @commentable = Blog.find(params[:blog_id]) rescue Tweet.find_by(slug: params[:tweet_id])
    elsif params[:tweet_id]
      @commentable = Tweet.find(params[:tweet_id]) rescue Blog.find_by(slug: params[:blog_id])
    end
  end
  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
  def find_commentable
    # byebug
    if params[:tweet_id]
      Tweet.find(params[:tweet_id]) rescue Tweet.find_by(slug: params[:tweet_id])
    elsif params[:blog_id]
      Blog.find(params[:blog_id]) rescue Blog.find_by(slug: params[:blog_id])
    end
  end
end
