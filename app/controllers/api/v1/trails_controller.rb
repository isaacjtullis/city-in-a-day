class Api::V1::TrailsController < ApplicationController

  def index
    all_trails = Trail.all
    all_users = User.all
    # all_trails.each_ei((trail, index) => {
    #   if((index + 1) <= 5){
    #     console.log(trail.trail_photo.url);
    #     $('.display-trails').append('<div class="image"></div>');
    #     trails.shift();
    #   }
    # })
    respond_to do |format|
      format.json { render json: [all_trails, all_users] }  # respond with the created JSON object
    end
  end

end
