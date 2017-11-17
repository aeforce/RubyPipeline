Rails.application.routes.draw do
  
  resources :events do
    resources :competitions do
      resources :user_competitions do
        collection do
          get :join
        end
      end
    end
  end
  devise_for :users
  resources :users, only:[:index, :new, :edit] do
    collection do
      post :add_user
    end
    member do
      patch :update_user
    end
  end
  resources :roles
  resources :accounts do
    member do
      get :transfer
    end
  end

  mount ActionCable.server => '/cable'
  
  
  root 'home#index'
end

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                         Controller#Action
#                              event_types GET    /event_types(.:format)                                                              event_types#index
#                                          POST   /event_types(.:format)                                                              event_types#create
#                           new_event_type GET    /event_types/new(.:format)                                                          event_types#new
#                          edit_event_type GET    /event_types/:id/edit(.:format)                                                     event_types#edit
#                               event_type GET    /event_types/:id(.:format)                                                          event_types#show
#                                          PATCH  /event_types/:id(.:format)                                                          event_types#update
#                                          PUT    /event_types/:id(.:format)                                                          event_types#update
#                                          DELETE /event_types/:id(.:format)                                                          event_types#destroy
# join_event_competition_user_competitions GET    /events/:event_id/competitions/:competition_id/user_competitions/join(.:format)     user_competitions#join
#      event_competition_user_competitions GET    /events/:event_id/competitions/:competition_id/user_competitions(.:format)          user_competitions#index
#                                          POST   /events/:event_id/competitions/:competition_id/user_competitions(.:format)          user_competitions#create
#   new_event_competition_user_competition GET    /events/:event_id/competitions/:competition_id/user_competitions/new(.:format)      user_competitions#new
#  edit_event_competition_user_competition GET    /events/:event_id/competitions/:competition_id/user_competitions/:id/edit(.:format) user_competitions#edit
#       event_competition_user_competition GET    /events/:event_id/competitions/:competition_id/user_competitions/:id(.:format)      user_competitions#show
#                                          PATCH  /events/:event_id/competitions/:competition_id/user_competitions/:id(.:format)      user_competitions#update
#                                          PUT    /events/:event_id/competitions/:competition_id/user_competitions/:id(.:format)      user_competitions#update
#                                          DELETE /events/:event_id/competitions/:competition_id/user_competitions/:id(.:format)      user_competitions#destroy
#                       event_competitions GET    /events/:event_id/competitions(.:format)                                            competitions#index
#                                          POST   /events/:event_id/competitions(.:format)                                            competitions#create
#                    new_event_competition GET    /events/:event_id/competitions/new(.:format)                                        competitions#new
#                   edit_event_competition GET    /events/:event_id/competitions/:id/edit(.:format)                                   competitions#edit
#                        event_competition GET    /events/:event_id/competitions/:id(.:format)                                        competitions#show
#                                          PATCH  /events/:event_id/competitions/:id(.:format)                                        competitions#update
#                                          PUT    /events/:event_id/competitions/:id(.:format)                                        competitions#update
#                                          DELETE /events/:event_id/competitions/:id(.:format)                                        competitions#destroy
#                                   events GET    /events(.:format)                                                                   events#index
#                                          POST   /events(.:format)                                                                   events#create
#                                new_event GET    /events/new(.:format)                                                               events#new
#                               edit_event GET    /events/:id/edit(.:format)                                                          events#edit
#                                    event GET    /events/:id(.:format)                                                               events#show
#                                          PATCH  /events/:id(.:format)                                                               events#update
#                                          PUT    /events/:id(.:format)                                                               events#update
#                                          DELETE /events/:id(.:format)                                                               events#destroy
#                         new_user_session GET    /users/sign_in(.:format)                                                            devise/sessions#new
#                             user_session POST   /users/sign_in(.:format)                                                            devise/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                           devise/sessions#destroy
#                        new_user_password GET    /users/password/new(.:format)                                                       devise/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                                                      devise/passwords#edit
#                            user_password PATCH  /users/password(.:format)                                                           devise/passwords#update
#                                          PUT    /users/password(.:format)                                                           devise/passwords#update
#                                          POST   /users/password(.:format)                                                           devise/passwords#create
#                 cancel_user_registration GET    /users/cancel(.:format)                                                             devise/registrations#cancel
#                    new_user_registration GET    /users/sign_up(.:format)                                                            devise/registrations#new
#                   edit_user_registration GET    /users/edit(.:format)                                                               devise/registrations#edit
#                        user_registration PATCH  /users(.:format)                                                                    devise/registrations#update
#                                          PUT    /users(.:format)                                                                    devise/registrations#update
#                                          DELETE /users(.:format)                                                                    devise/registrations#destroy
#                                          POST   /users(.:format)                                                                    devise/registrations#create
#                           add_user_users POST   /users/add_user(.:format)                                                           users#add_user
#                         update_user_user PATCH  /users/:id/update_user(.:format)                                                    users#update_user
#                                    users GET    /users(.:format)                                                                    users#index
#                                 new_user GET    /users/new(.:format)                                                                users#new
#                                edit_user GET    /users/:id/edit(.:format)                                                           users#edit
#                                    roles GET    /roles(.:format)                                                                    roles#index
#                                          POST   /roles(.:format)                                                                    roles#create
#                                 new_role GET    /roles/new(.:format)                                                                roles#new
#                                edit_role GET    /roles/:id/edit(.:format)                                                           roles#edit
#                                     role GET    /roles/:id(.:format)                                                                roles#show
#                                          PATCH  /roles/:id(.:format)                                                                roles#update
#                                          PUT    /roles/:id(.:format)                                                                roles#update
#                                          DELETE /roles/:id(.:format)                                                                roles#destroy
#                         transfer_account GET    /accounts/:id/transfer(.:format)                                                    accounts#transfer
#                                 accounts GET    /accounts(.:format)                                                                 accounts#index
#                                          POST   /accounts(.:format)                                                                 accounts#create
#                              new_account GET    /accounts/new(.:format)                                                             accounts#new
#                             edit_account GET    /accounts/:id/edit(.:format)                                                        accounts#edit
#                                  account GET    /accounts/:id(.:format)                                                             accounts#show
#                                          PATCH  /accounts/:id(.:format)                                                             accounts#update
#                                          PUT    /accounts/:id(.:format)                                                             accounts#update
#                                          DELETE /accounts/:id(.:format)                                                             accounts#destroy
#                                                 /cable                                                                              #<ActionCable::Server::Base:0x007fc9b3fc6438 @mutex=#<Monitor:0x007fc9b3fc63c0 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fc9b3fc6370>>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
#                                     root GET    /                                                                                   users#index
# 
