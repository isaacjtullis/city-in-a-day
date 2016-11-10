class RelationshipsController < ApplicationController
  before_action :require_login

  def create
    @user_to_follow = params[:relationship][:followed_id].to_i

    if params[:relationship][:followed_id] != current_user.id
      current_user.follow(@user_to_follow)
      redirect_to profile_path(@user_to_follow)
    else
      flash[:notice] = 'error'
      redirect_to profile_path(@user_to_follow)
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])
    profile_id = relationship.followed_id
    current_user.unfollow(relationship.followed_id)
    redirect_to profile_path(profile_id)

  end

  protected
  def require_login
    unless current_user
      flash[:notice] = "You must be logged in to make changes!"
      redirect_to root_path
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id).merge(follower_id: current_user.id)
  end
end
