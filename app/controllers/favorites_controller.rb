class FavoritesController < ApplicationController
  before_action :require_login

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      redirect_to root_path
    end
  end

  def destroy
    @favorite = Favorite.where(trail_id: params[:id], user_id: current_user.id)
    if current_user.nil?
      flash[:notice] = "You cannot remove what is not yours. Dumbass."
      redirect_to trail_path(params[:id])
    else
      @favorite.first.destroy
      flash[:notice] = "Successfully removed this from your favorites"
      redirect_to profile_path(current_user)
    end
  end

  protected
  def require_login
    unless current_user
      flash[:notice] = "You must be logged in to make changes!"
      redirect_to root_path
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:trail_id).merge(user_id: current_user.id)
  end
end
