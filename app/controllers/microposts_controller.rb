class MicropostsController < ApplicationController
  #   if the user does not login, he cannot use [create] method,
  #   and will be redirected to /login
  before_action :logged_in_user, only: [:create]

  # create 
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Miiffypost is created successfully!"
      # redirect_to user_url
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  # delete
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Miffypost is being deleted successfully!"
    redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
