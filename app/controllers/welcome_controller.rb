class WelcomeController < ActionController::Base
  def index
    redirect_to user_signed_in? ? tickets_path : new_ticket_path
  end
end
