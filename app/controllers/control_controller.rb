class ControlController < ApplicationController
  before_action :require_login, except: [:auth,:login]
  def index
    @limit = 10
    @statuses = TicketStatus.get_to_select
  end
  def auth
    
  end
  def get_tickets
    method = 'get_'+params[:type].to_s+'_tickets'
    tickets = Ticket.send(method,params[:offset].to_i) if Ticket.respond_to?(method)
    render :json=>tickets
  end
  def login
    user = User.auth(params[:login], params[:password])
    if user.nil?
      flash[:error] = 'Login or password incorrect'
      redirect_to control_auth_path 
    else
      session[:current_user_id] = user.id
      flash[:success] = 'Welcome '+user.first_name.to_s+' '+user.last_name.to_s
      redirect_to control_path
    end
  end
  def logout
    session[:current_user_id] = nil
    flash[:success] = 'Bye-bye'
    redirect_to index_index_path
  end
  private
  def require_login
    redirect_to control_auth_path unless is_logged?
  end
  def is_logged?
    !current_user.nil?
  end
  def current_user
    @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end
end
