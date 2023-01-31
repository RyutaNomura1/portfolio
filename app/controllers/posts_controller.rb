class PostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_post_user, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "#{@post.title}を投稿しました"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def index
    unless logged_in?
      redirect_to top_path
    end
    posts = Post.all
    questions = Question.all
    @lists =  posts | questions
    # @lists = [].concat(posts, questions)
    @lists.sort!{ |a, b| b.created_at <=> a.created_at }    
    
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "#{@post}を更新しました"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image, :location)
  end
end