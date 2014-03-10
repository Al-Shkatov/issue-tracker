class TicketNotify < ActionMailer::Base
  default from: "cmb_5@ukr.net"
  def new_ticket(ticket)
    @ticket = ticket
    mail(to: @ticket.customer_email, subject: 'You create new ticket '+ticket.uid.to_s)
  end
  def changes_in_ticket(ticket,comment)
    @ticket = ticket
    @comment = comment
    mail(to: @ticket.customer_email, subject: 'New comment in ticket '+ticket.uid.to_s)
  end
end
