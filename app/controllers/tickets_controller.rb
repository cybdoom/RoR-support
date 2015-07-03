class TicketsController < ActionController::Base
  layout 'application'

  respond_to :html, :json

  before_action :authenticate_user!, only: [:index, :update, :search]
  before_action :ensure_signed_out, only: [:show]

  def new
    @ticket = Ticket.new ticket_attributes
    respond_with @ticket
  end

  def index
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_with @ticket
  end

  def create
    @ticket = Ticket.new ticket_attributes
    if @ticket.save
      flash[:notice] = 'Ticket was succesfully created'
      CustomerMailer.ticket_created(@ticket).deliver
      redirect_to action: 'new'
    else
      message = @ticket.errors.full_messages.join('<br>').html_safe
      flash[:error] = message
      redirect_to action: 'new', ticket: ticket_attributes
    end
  end

  def update
    @ticket = Ticket.find params[:id]
    @ticket.update_attributes ticket_attributes

    render @ticket
  end

  def comment
    @ticket = Ticket.find params[:id]

    @comment = Comment.new comment_attributes
    @comment.ticket_id = @ticket.id
    @comment.reply = user_signed_in?

    if @comment.save
      CustomerMailer.ticket_commented(@ticket, @comment).deliver if @comment.reply
      render @comment
    else
      render nothing: true
    end
  end

  def search
    @tickets = Ticket.search_by_key search_params
    respond_with @tickets
  end

  private

  def ensure_signed_out
    sign_out current_user if user_signed_in?
  end

  def ticket_attributes
    begin
      params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :description, :status)
    rescue
      nil
    end
  end

  def comment_attributes
    params.require(:comment).permit(:text)
  end

  def search_params
    params.require(:search_key)
  end
end
