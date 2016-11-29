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
  end

  def show
    @trail = Trail.find(params[:id])
    @user = User.find(@trail.user_id)
    @location = Location.new
    @locations = Location.where(trail_id: @trail.id)
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
      flash[:notice] = 'You must be signed in'
      render 'index'
    else
      flash[:notice] = 'Opps. We got some problems with that form'
      render 'new'
    end
  end

  private

  def trail_params
    params.require(:trail).permit( :name, :mood, :trail_photo)
  end
end
