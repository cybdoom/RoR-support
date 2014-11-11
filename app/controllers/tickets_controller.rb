class TicketsController < ActionController::Base
  layout 'application'

  before_action :authenticate_user!, only: [:index]

  def new
    @ticket = Ticket.new ticket_attributes
  end

  def index
  end

  def create
    @ticket = Ticket.new ticket_attributes
    if @ticket.save
      flash[:notice] = 'Ticket was succesfully created'
      redirect_to action: 'new'
    else
      message = @ticket.errors.messages.each.map {|k, v| "#{k.to_s.humanize}: #{v.join(', ')}" }.join('<br>').html_safe
      flash[:error] = message
      redirect_to action: 'new', ticket: ticket_attributes
    end
  end

  private

  def ticket_attributes
    begin
      params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :description)
    rescue
      nil
    end
  end
end
