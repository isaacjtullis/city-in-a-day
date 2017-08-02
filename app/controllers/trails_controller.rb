class TrailsController < ApplicationController
  def index
    @all_trails = Trail.all
    if params[:search] == ""
      @trails = nil
    elsif !params[:search].nil? && params[:search] != ""
      if Trail.search(params[:search]).empty?
        @error = 'Sorry, we cannot find what you are looking for'
      else
        @trails = Trail.search(params[:search])
      end
    end
    @favorite = Favorite.new
  end

  def new
    @trail = Trail.new
    @user = User.find(current_user)
  end

  def show
    @trail = Trail.find(params[:id])
    @user = User.find(@trail.user_id)
    @location = Location.new
    locations = Location.where(trail_id: @trail.id)
    @locations = locations.sort { |x, y| x.order <=> y.order }
    @comment = Comment.new
    @comments = Comment.where(trail_id: @trail.id)
  end

  def create
    @trail = Trail.new(trail_params)
    @trail.user = current_user
    if @trail.save
      flash[:notice] = 'Congrats! You have an adventure name.'
      redirect_to new_trail_location_path(@trail.id)
    elsif current_user.nil?
      flash[:notice] = 'Sign up for an account to start sharing today.'
      render 'index'
    else
      flash[:notice] = 'Opps. We got some problems with that form'
      render 'new'
    end
  end

  def edit
    @trail = Trail.find(params[:id])
    flash[:notice] = "You cannot modify an account that is not yours" if current_user.id != @trail.user_id
  end

  def update
    @trail = Trail.find(params[:id])
    if @trail.update(trail_params)
      flash[:notice] = 'You have successfully modified your profile'
      redirect_to trail_path(@trail)
    else
      render :edit
    end
  end

  def destroy
    trail = Trail.find(params[:id])
    if trail.user_id != current_user.id
      flash[:notice] = "You cannot delete a location you did not make!"
      redirect_to trail
    else
      trail.destroy
      flash[:notice] = "Trail successfully deleted!"
      redirect_to trail
    end
  end

  private

  def trail_params
    params.require(:trail).permit( :name, :mood, :trail_photo)
  end
end
