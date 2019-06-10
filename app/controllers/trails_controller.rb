class TrailsController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  #
  # loading in devise variables start
  #
  def resource_name
   :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #
  # loading in devise variables end
  #

  def edit
    binding.pry
    @trail = Trail.find(params[:id])
    if current_user.id != @trail.user_id
      flash[:notice] = 'You didnt make this!'
      redirect_to @trail
    end
  end

  def update
      @trail = Trail.find(params[:id])
      #comment
      if @trail.update(trail_params)
        flash[:notice] = 'Congrats! Location edited'
        redirect_to @trail
      else
        flash[:notice] = 'Opps. We got some problems with that'
        render 'edit'
      end
  end

  def index
    # This code will be put back inside of @trails when we have better
    # Default images
    # <%= image_tag trail.trail_photo.to_s if !trail.trail_photo.nil? %>
    @trails = Trail.where(name: params[:city])

    @all_users = User.all
    # all_trails = {}
    # user_trails user_id trail_id rating
    # @trails = Trail.all.includes(:user)
    # binding.pry
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

  # def edit
  #   @trail = Trail.find(params[:trail_id])
  #   @trail = Trail.find(@location.trail_id)
  #   if current_user.id != @trail.user_id
  #     flash[:notice] = 'You didnt make this!'
  #     redirect_to @trail
  #   end
  # end

  def show
    @trail = Trail.find(params[:id])
    @user = @trail.user
    # @user = User.find(@trail.user_id)
    # @location = Location.new
    # @locations = Location.where(trail_id: @trail.id)
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

  # private

  def trail_params
    params.require(:trail).permit( :name, :mood, :trail_photo, :city_name)
  end
end
