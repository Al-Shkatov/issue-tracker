class TicketCommentsController < ApplicationController
  def create
    ticket = Ticket.find(params[:ticket_id])
    comment = ticket.ticket_comments.new(comments_params)
    ticket.user_id = comment.user_id = session[:current_user_id]
    ticket.save
    flash[:error] = 'Type comment before send it' unless comment.save
    redirect_to ticket_uid_path(ticket.uid)
  end
  private
  def comments_params
    params.require(:ticket_comment).permit(:body, :parent_id)
  end
end
