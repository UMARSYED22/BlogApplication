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
    @comment = current_user.comments.build(comment_params)
    puts "Generated slug: #{@comment.slug}" # Debugging line
    if @comment.save
      redirect_to @comment, notice: "Comment was successfully created."
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
    @comment.destroy
    redirect_to comments_url, notice: "Comment was successfully destroyed."
  end
  private
  def set_commentable
    @commentable = Blog.find_by(slug: params[:blog_id]) || Blog.find(params[:blog_id])
  end
  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end
