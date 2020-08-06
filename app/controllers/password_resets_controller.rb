class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".info"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_notfound"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".empty")
      render :edit
    elsif @user.update user_params.merge reset_digest: nil
      reset_password @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    redirect_to root_url unless @user&.activated? && @user&.authenticated?(:reset, params[:id])
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".exporation"
    redirect_to new_password_reset_url
  end

  def reset_password user
    log_in user
    flash[:success] = t ".reset"
    redirect_to user_path locale, user
  end
end
