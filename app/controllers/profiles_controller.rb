class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @trails = @user.trails
    @favorites = @user.favorites
    @relationship = Relationship.new
  end

  def edit
    @user = User.find(current_user.id)
    flash[:notice] = "You cannot modify an account that is not yours" if current_user.id != @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have successfully modified your profile'
      redirect_to profile_path(@user)
    else
      render :edit
    end
  end

  def user_params
  params.require(:user).permit(
    :bio,
    :password,
    :email
  )
  end
end
