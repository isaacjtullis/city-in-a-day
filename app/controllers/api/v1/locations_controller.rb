class Api::V1::LocationsController < ApplicationController

  def create
    @location = Location.new(location_params)
    if @location.save
      binding.pry
      flash[:notice] = 'Congrats! Location saved'
      render json: { trail_id: @location.trail_id }.to_json
      else
      flash[:notice] = 'Opps. We got some problems with that form'
      render json: :nothing, status: :not_found
    end
  end

  private

  def location_params
    params.require(:location).permit( :location, :description, :name, :price, :trail_id)
  end
end
