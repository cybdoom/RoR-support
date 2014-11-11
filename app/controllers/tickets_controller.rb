class TicketsController < ActionController::Base
  layout 'application'

  before_action :authenticate_user!, only: [:index]

  def new
    @ticket = Ticket.new
  end

  def index
  end

  def create
    attributes = params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :description)
    @ticket = Ticket.new attributes
    if @ticket.save
      flash[:notice] = 'Ticket was succesfully created'
    else
      message = @ticket.errors.messages.each.map {|k, v| "#{k.to_s.humanize}: #{v.join(', ')}" }.join('<br>').html_safe
      flash[:error] = message unless @ticket.save
    end

    redirect_to :back
  end
end
