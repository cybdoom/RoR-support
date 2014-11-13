class CustomerMailer < ActionMailer::Base
  default from: "onapp.mailer@gmail.com"

  def ticket_created ticket
    @ticket = ticket
    mail(to: ticket.customer_email, subject: "Ticket was created")
  end
end
