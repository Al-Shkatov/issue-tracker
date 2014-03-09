class TicketNotify < ActionMailer::Base
  default from: "cmb_5@ukr.net"
  def new_ticket(ticket)
    @ticket = ticket
    mail(to: @ticket.customer_email, subject: 'You created new ticket')
  end
  def changes_in_ticket(ticket)
    
  end
end
