class HomeController < ApplicationController


  def index
    if @current_user_role == AppConstants::SUPER_ADMIN
      redirect_to users_path
    else
      redirect_to events_path
    end


  end

end
