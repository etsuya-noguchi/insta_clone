class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]


  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    if @blog.save
      ContactMailer.contact_mail(@blog).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
   @blog = Blog.new(blog_params)
   @blog.user_id = current_user.id
   render :new if @blog.invalid?
  end

  private

  def blog_params
   params.require(:blog).permit(:title, :content,:image, :image_cache)
  end

  def set_blog
   @blog = Blog.find(params[:id])
  end
end
