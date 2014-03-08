class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
    @departments = Department.find :all
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @departments = Department.find :all
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.valid?
      new = @ticket.new_record?
      if @ticket.save
        new ? TicketNotify.new_ticket(@ticket) : TicketNotify.changes_in_ticket(@ticket)
      end
    end
  end

  def comment
    
  end

  def show
    
  end
  
  def destroy
  end

  def change_status
  end
  private 
  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id)
  end
end
