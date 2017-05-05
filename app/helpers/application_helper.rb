module ApplicationHelper
  def user_avatar(user)
    if !user.empty?
      image_tag user.to_s
    else
      # Assuming you have a default.jpg in your assets folder
      image_tag user.default_url
    end
  end
end

#@trail.trail_photo.to_s if !@trail.trail_photo.nil?
