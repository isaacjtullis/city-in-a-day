class LocationsController < ApplicationController
  def new
    @location = Location.new
    @trail = Trail.find(params[:trail_id])
  end

  def edit
    @location = Location.find(params[:trail_id])
    @trail = Trail.find(params[:id])
    if current_user.id != @trail.user_id
      flash[:notice] = 'You didnt make this jackass'
      redirect_to @trail
    end
  end

  def update
    @location = Location.find(params[:id])
<<<<<<< Updated upstream
    @trail = Trail.find(params[:trail_id])
=======
    @trail = Trail.find(@location.trail_id)
>>>>>>> Stashed changes
    if @location.update(location_params)
      flash[:notice] = 'Congrats! Location edited'
      redirect_to @trail
    else
      flash[:notice] = 'Opps. We got some problems with that'
      render 'edit'
    end
  end

  def create
    @location = Location.new(location_params)
    @trail = Trail.find(params[:trail_id])
    order = @trail.locations.length + 1
    @location.order = order
    if @location.save
      flash[:notice] = 'Congrats! Location saved'
      redirect_to @trail
    else
      flash[:notice] = 'Opps. We got some problems with that form'
      render 'new'
    end
  end

  def destroy
    location = Location.find(params[:trail_id])
    trail = Trail.find(params[:id])
    if trail.user_id != current_user.id
      flash[:notice] = "You cannot delete a location you did not make!"
      redirect_to trail
    else
      location.destroy
      flash[:notice] = "Location deleted!"
      redirect_to trail
    end
  end

  private

  def location_params
    params.require(:location).permit( :location, :description, :name, :price, :trail_id, :photos)
  end
end
