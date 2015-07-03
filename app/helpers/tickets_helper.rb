module TicketsHelper
  STATUS_ICONS = %w(fa-wrench fa-reply fa-clock-o fa-trash fa-check-circle-o)

  def status_icon_class arg
    arg.is_a?(Ticket) ? STATUS_ICONS[arg.status] : STATUS_ICONS[arg]
  end

  def status_name ticket
    Ticket::STATUSES[ticket.status]
  end

  def department_name ticket
    Ticket::DEPARTMENTS[ticket.department]
  end
end
