class Api::V1::LocationsController < ApplicationController

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = 'Congrats! Location saved'
      render json: { trail_id: @location.trail_id }.to_json
      else
      flash[:notice] = 'Opps. We got some problems with that form'
      render json: :nothing, status: :not_found
    end
  end

  def update
    firstOrder = params[:location][:oIndex]
    secondOrder = params[:location][:nIndex]
    if firstOrder != secondOrder && secondOrder != firstOrder
      nIndex = secondOrder.to_i + 1
      secondIndex = firstOrder.to_i
      trail_id = params[:location][:trail_id]
      locations = Location.where(trail_id: trail_id)
      @locationTwo = locations.where(order: secondOrder)
      @locationOne = locations.where(order: firstOrder)
      @locationOrder = @locationTwo[0].order.to_i + 1
      @locationOne[0].order = params[:location][:nIndex]
      @locationOne.update(order: params[:location][:nIndex])
      @this = locations.where(:order => nIndex..secondIndex)
      #@this = locations.where(order: nIndex..Float::secondIndex)
      @this.each do |item|
        item.update(order: item.order.to_i + 1)
      end
      @locationTwo.update(order: @locationOrder)
    end
    #@locationOne = locations.where(order: firstOrder)
    # @locationTwo = locations.where(order: secondOrder)
    #@locationOne[0].order = params[:location][:nIndex]
    # @locationTwo[0].order = params[:location][:oIndex]
    #@locationOne.update(order: params[:location][:nIndex])
    # @locationTwo.update(order: params[:location][:oIndex])
    # location_index = location.where(order: order)
    # basically I need to send up the new order for this guy and update him.
    # which means I need to also update the order of the other guy
    # which means I should send up an array? hmm...
  end

  private

  def location_params
    params.require(:location).permit( :location, :description, :name, :price, :trail_id, :order, :oIndex, :nIndex)
  end
end
