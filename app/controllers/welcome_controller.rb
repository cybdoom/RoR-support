class WelcomeController < ActionController::Base
  def index
    redirect_to(user_signed_in? ? "/tickets/index" : "/tickets/new")
  end
end
