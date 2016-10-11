class TrailsController < ApplicationController
  def index
  end

  def new
    @trail = Trail.new
  end

  def show
    @trail = Trail.find(params[:id])
  end

  def create
    @trail = Trail.new(trail_params)
    @trail.user = current_user
    if @trail.save
      flash[:notice] = 'Congrats! You have made a new adventure.'
      redirect_to trail_path(@trail)
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
    params.require(:trail).permit(:description, :location, :name, :price, :mood)
  end
end
