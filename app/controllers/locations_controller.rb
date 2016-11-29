class LocationsController < ApplicationController
  def new
    @location = Location.new
    @trail = Trail.find(params[:trail_id])
  end

  def create
    @location = Location.new(location_params)
    @trail = Trail.find(params[:trail_id])
    @location.trail_id = @trail.id
    if @location.save
      flash[:notice] = 'Congrats! Location saved'
      redirect_to @trail
    else
      flash[:notice] = 'Opps. We got some problems with that form'
      render 'new'
    end
  end

  private

  def location_params
    params.require(:location).permit( :location, :description, :name, :price, :trail_id)
  end
end
