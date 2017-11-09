class Api::V1::LocationsController < ApplicationController

  def create
    @location = Location.new(location_params)
    @trail = Trail.find(location_params[:trail_id])
    order = @trail.locations.length + 1
    @location.order = order
    if @location.save
      binding.pry
      flash[:notice] = 'Congrats! Location saved'
      render json: { trail_id: @location.trail_id }.to_json
      else
      flash[:notice] = 'Opps. We got some problems with that form'
      render json: :nothing, status: :not_found
    end
  end

  def update
    #binding.pry
    oldIndex = params[:location][:oIndex]
    newIndex = params[:location][:nIndex]
    trail_id = params[:location][:trail_id]
    @trail = Trail.where(trail_id: trail_id)
    locations = Location.where(trail_id: trail_id)
    # binding.pry
    if newIndex != oldIndex && oldIndex > newIndex
      nIndex = newIndex.to_i
      # nIndexMinusOne = nIndex - 1
      # oIndexMinusOne = oldIndex.to_i - 1
      oIndex = oldIndex.to_i
      # we find the old location of our item
      # movingLocation = locations.where(order: oldIndex)
      #binding.pry
      #
      movingLocation.update(order: newIndex.to_i - 1)
      findAffectedLocations = locations.where(order: nIndex..oIndex)
      #binding.pry
      findAffectedLocations.each do |item|
        item.update(order: item.order.to_i + 1)
      end
      # binding.pry
      #binding.pry
      #binding.pry
      movingLocation.update(order: newIndex)
    elsif newIndex != oldIndex && newIndex > oldIndex
      nIndex = newIndex.to_i
      oIndex = oldIndex.to_i
      movingLocation = locations.where(order: oldIndex)
      #movingLocation.update(order: newIndex.to_i + 1)
      findAffectedLocations = locations.where(order: oIndex..nIndex)
      findAffectedLocations.each do |item|
        item.update(order: item.order.to_i - 1)
      end
      # binding.pry
      #binding.pry
      movingLocation.update(order: newIndex)
    end
    # if firstOrder != secondOrder && secondOrder != firstOrder
    #   nIndex = secondOrder.to_i + 1
    #   secondIndex = firstOrder.to_i
    #   trail_id = params[:location][:trail_id]
    #   locations = Location.where(trail_id: trail_id)
    #   @locationTwo = locations.where(order: secondOrder)
    #   @locationOne = locations.where(order: firstOrder)
    #   @locationOrder = @locationTwo[0].order.to_i + 1
    #   @locationOne[0].order = params[:location][:nIndex]
    #   @locationOne.update(order: params[:location][:nIndex])
    #   @this = locations.where(:order => nIndex..secondIndex)
    #   #@this = locations.where(order: nIndex..Float::secondIndex)
    #   @this.each do |item|
    #     item.update(order: item.order.to_i + 1)
    #   end
    #   @locationTwo.update(order: @locationOrder)
    # end
    #@locationOne = locations.where(order: firstOrder)
    # @locationTwo = locations.where(order: secondOrder)
    #@locationOne[0].order = params[:location][:nIndex]
    # @locationTwo[0].order = params[:location][:oIndex]
    #@locationOne.update(order: params[:location][:nIndex])
    # @locationTwo.update(order: params[:location][:oIndex])
    # basically I need to send up the new order for this guy and update him.
    # which means I need to also update the order of the other guy
    # which means I should send up an array? hmm...
  end

  private

  def location_params
    params.require(:location).permit(:photos, :location, :description, :name, :price, :trail_id, :order, :oIndex, :nIndex)
  end
end
