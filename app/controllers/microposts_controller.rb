class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per Settings.pagination.per_page
      redirect_to "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t ".success"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
