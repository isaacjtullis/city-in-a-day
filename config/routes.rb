Rails.application.routes.draw do
  # get 'welcome/index'

  devise_for :users
  # root 'trails#index'
  root 'welcome#index'

  resources :trails do
    resources :comments, only: [:create, :edit, :destroy]
    resources :locations
  end

  resources :searches

  namespace :api do
    namespace :v1 do
      resources :locations
      resources :trails
    end
  end

  resources :profiles
  resources :favorites, only: [:create, :destroy, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
end


# <div class="row justify-content-center">
#   <div class="card-group">
#       <% if !@trails.nil? %>
#         <%= @trails.each do |trail| %>
#             <div class="col-md-4 card trail-card">
#                 <img class="card-img-top"><%= image_tag trail.trail_photo.to_s if !trail.trail_photo.nil? %></img>
#                 <div class="card-body">
#                   <%= link_to trail.name, trail_path(trail.id) %>
#                   <%= simple_form_for @favorite do |f| %>
#                     <div class="post-close">
#                       <%= f.input :trail_id, as: :hidden, input_html: { value: trail.id } %>
#                       <%= f.submit %>
#                     </div>
#                   <% end %>
#                 </div>
#             </div>
#         <% end %>
#       <% end %>
#     </div>
# </div>
