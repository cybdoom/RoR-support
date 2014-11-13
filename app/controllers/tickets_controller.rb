class TicketsController < ActionController::Base
  layout 'application'

  before_action :authenticate_user!, only: [:index]

  def new
    @ticket = Ticket.new ticket_attributes
  end

  def index
    @tickets = Ticket.all
  end

  def create
    @ticket = Ticket.new ticket_attributes
    if @ticket.save
      flash[:notice] = 'Ticket was succesfully created'
      redirect_to action: 'new'
    else
      message = error_message @tichet
      flash[:error] = message
      redirect_to action: 'new', ticket: ticket_attributes
    end
  end

  def update
    @ticket = Ticket.find params[:id]
    @ticket.send("#{ params[:field] }=".to_sym, params[:value])
    render json: {
      field: params[:field],
      value: params[:value],
      iconClass: params[:field] == 'user_id' ? 'fa-user' : Ticket::STATUS_ICONS[params[:value].to_i],
      title: params[:field] == 'user_id' ? "Owner: #{ User.find(params[:value].to_i).email }" : Ticket::STATUSES[params[:value].to_i]
    }, status: @ticket.save ? 200 : 500
  end

  private

  def error_message record
    record.errors.messages.each.map {|k, v| "#{k.to_s.humanize}: #{v.join(', ')}" }.join('<br>').html_safe
  end

  def ticket_attributes
    begin
      params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :description)
    rescue
      nil
    end
  end
end
