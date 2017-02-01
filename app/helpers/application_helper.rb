module ApplicationHelper
  def user_avatar(user)
    binding.pry
    if !user.empty?
      image_tag user.to_s
    else
      # Assuming you have a default.jpg in your assets folder
      binding.pry
      image_tag user.default_url
    end
  end
end

#@trail.trail_photo.to_s if !@trail.trail_photo.nil?
