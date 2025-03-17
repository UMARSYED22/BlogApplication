class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_blog, only: [ :show, :edit, :update, :destroy, :publish ]
  before_action :authorize_user, only: [ :edit, :update, :destroy, :publish ]

  access all: [ :show, :index ], user: { except: [ :destroy, :new, :create, :update, :edit, :publish ] }, admin: :all

  def index
    @blogs = Blog.where(status: :published)
  end

  def show
    @comments = @blog.comments
  end

  def new
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    @blog.status = :draft
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new
    end
  end

  def publish
    if @blog.draft?
      @blog.published!
      redirect_to @blog, notice: "Blog was successfully published."
    else
      redirect_to @blog, alert: "Blog is already published."
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "Blog was successfully destroyed."
  end

  def my_blogs
    @blogs = current_user.blogs
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def authorize_user
    unless current_user == @blog.user || current_user.has_role?(:admin)
      redirect_to blogs_path, alert: "You are not authorized to perform this action."
    end
  end
end
