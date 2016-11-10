class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @trails = @user.trails
    @favorites = Trail.joins(:favorites)
    @relationship = Relationship.new
    #Trail.joins(favorites: :user)
  end

  def edit
    @user = User.find(params[:id])
    flash[:notice] = "You cannot modify an account that is not yours" if current_user.id != @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have successfully modified your profile'
      redirect_to profile_path(@user)
    else
      flash[:notice] = 'Something did not save.'
      render :edit
    end
  end

  def user_params
  params.require(:user).permit(
    :bio
  )
  end
end

#gogole charts
#normal CSS
#go to a site i like a find their css
#google maps trace path
#sitepoint.com/use-google-maps-rails/
