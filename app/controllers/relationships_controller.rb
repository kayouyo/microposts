class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # フォローする他のユーザーのIDをパラメータとして受け取り、
  # 見つかったユーザーを引数としてUserモデルのfollowメソッドを実行する。
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
