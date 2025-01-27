class PostsController < ApplicationController
  # bookroom2では投稿の閲覧についてはログインを必要としないことにする
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # ログインユーザのIDを代入
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to posts_path
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show # 追加
    @post = Post.find_by(id: params[:id])
  end

  def index # 追加
    @posts = Post.limit(10).order(created_at: :desc)
  end


  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
