class TicketsController < ApplicationController
  before_filter :init_departments, :only=>[:new, :edit, :create, :update]
  
  def index
    
  end
  def new
    @ticket = Ticket.new
  end
  def edit
    @ticket = Ticket.find(params[:id])
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = session[:current_user_id]
    if @ticket.save
      TicketNotify.new_ticket(@ticket).deliver
      flash[:success] = 'Your ticket has been created. Ticket UID is '+@ticket.uid
      redirect_to @ticket
    else
      flash[:error] = 'Please correct highlighted fields'
      render 'new'
    end
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    @ticket.user_id = session[:current_user_id]
    if @ticket.save
      TicketNotify.changes_in_ticket(@ticket).deliver
      flash[:success] = 'Ticket has been changed'
      redirect_to @ticket
    else
      flash[:error] = 'Please correct highlighted fields'
      render 'edit'
    end
  end

  def comment
    
  end

  def show
    @ticket = Ticket.find(params[:id]) unless params[:id].nil?
    @ticket = Ticket.find_by(uid: params[:uid]) unless params[:uid].nil?
    @ticket_comments = @ticket.ticket_comments.parent_comments
    @statuses = TicketStatus.all
  end
  
  def destroy
  end

  def change_status
    ticket = Ticket.find(params[:ticket_id])
    ticket.ticket_status_id = params[:status_id]
    ticket.save
    render :json=>{type: Ticket.get_status_type(params[:status_id].to_i)}
  end
  private 
  def init_departments
    @departments = Department.find :all
  end
  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :body, :department_id)
  end
end
