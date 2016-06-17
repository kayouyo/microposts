class UsersController < ApplicationController
  # 編集・更新処理??
  before_action :set_user, only: [:show, :edit, :update]

  # show
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
