class FollowingController < ApplicationController
  before_action :logged_in_user, :find_user, only: :index

  def index
    @title = t ".following"
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page]
    render "users/show_follow"
  end
end
