class UsersController < ApplicationController
  # 編集・更新処理??
  # before_action :set_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:edit, :update]

  # show
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    @micropost = current_user.microposts.build if logged_in?
    
    # follower    
    followerall  = Relationship.where(followed_id: params[:id])
    
    p @follower_users = Array.new
    
    followerall.each do |follower|
    @follower_users << User.find_by(id: follower.follower_id)
    end
    
    # following
    followingall = Relationship.where(follower_id: params[:id])
    
    @following_users = Array.new
      
    followingall.each do |following|
    p @following_users << User.find_by(id: following.followed_id)
    end 
  end
  
  # new
  def new
    @user = User.new
  end
  
  # create user:新しい@userのデータを作成
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Miffy's World!"
      redirect_to @user 
      # redirect_to user_path(@user) if有bug,改回這行註解下一行
    else
      render 'new'
    end
  end
  
  # create user:
  def edit
    @user = User.find(params[:id])
  end
  
  # update user's new info:
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to user_path , notice: 'Your profile has been updated!'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  # def フォロワー、フォローの全データを取ってくるアクション
  def followings  
    @user = User.find(params[:id])
    followingall = Relationship.where(follower_id: params[:id])
    
    @following_users = Array.new
      
    followingall.each do |following|
    p @following_users << User.find_by(id: following.followed_id)
    end   
  end
  
  def followers
    @user  = User.find(params[:id])
    followerall  = Relationship.where(followed_id: params[:id])
    
    p @follower_users = Array.new
    
    followerall.each do |follower|
    @follower_users << User.find_by(id: follower.follower_id)
    end
  end
  # defと同じ名前のview作成
  # view　フォロワー、フォローの全データを表示する
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :country, :animal)
  end
  
  def set_user
    @user = User.find(params[:id])
    # 特定のUSERしか自分の情報をEDITできない only valid user can see, edit info
    redirect_to root_path if current_user != @user
  end
end
