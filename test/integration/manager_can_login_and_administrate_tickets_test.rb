require 'test_helper'

class ManagerCanLoginAndAdministrateTicketsTest < ActionDispatch::IntegrationTest
  fixtures :all
  test 'manager login' do
    open_session
    get '/control/index'
    assert_response :redirect
    
    post_via_redirect '/control/login', login: 'test', password: '123'
    assert_not_nil flash[:success]
    
    get '/control/index'
    assert_response :success
  end
  test 'manager change ticket status' do
    post '/tickets/change_status',{ticket_id: 4, status_id: 2}
    assert_not_equal Ticket.find(4).ticket_status_id, 2
    
    open_session
    post_via_redirect '/control/login', login: 'test', password: '123'
    
    post '/tickets/change_status',{ticket_id: 4, status_id: 2}
    assert_equal Ticket.find(4).ticket_status_id, 2
  end
end
