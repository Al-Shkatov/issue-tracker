class TicketsController < ApplicationController
  before_filter :init_departments, :only=>[:new, :edit, :create, :update]

  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = session[:current_user_id]
    if @ticket.save
      TicketNotify.new_ticket(@ticket).deliver
      flash[:success] = 'Your ticket has been created. Ticket UID is '+@ticket.uid
      redirect_to ticket_uid_path(@ticket.uid)
    else
      flash[:error] = 'Please correct highlighted fields'
      render 'new'
    end
  end
  
  def show
    @ticket = Ticket.find(params[:id]) unless params[:id].nil?
    @ticket = Ticket.find_by(uid: params[:uid]) unless params[:uid].nil?
    unless @ticket.nil?
      @ticket_comments = @ticket.ticket_comments.parent_comments
      @statuses = TicketStatus.all
    else
      redirect_to :back and return
    end
  end

  def change_status
    ticket = Ticket.find(params[:ticket_id])
    if is_logged?
      ticket.ticket_status_id = params[:status_id]
      ticket.user_id = session[:current_user_id]
      ticket.save
    end
    render :json=>{type: Ticket.get_status_type(ticket.ticket_status_id)}
  end
  private 
  def init_departments
    @departments = Department.all
  end
  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id)
  end
end
