class TicketsController < ActionController::Base
  layout 'application'

  before_action :authenticate_user!, only: [:index]

  def new
  end

  def index
  end
end
