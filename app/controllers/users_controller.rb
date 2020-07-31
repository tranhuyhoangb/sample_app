class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t(".flash", username: @user.name)
      redirect_to user_path(@user)
    else
      flash[:success] = "Create  Fail! >.<"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

end
