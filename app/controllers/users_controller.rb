class UsersController < ApplicationController
  # show
  def show
   @user = User.find(params[:id])
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
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
