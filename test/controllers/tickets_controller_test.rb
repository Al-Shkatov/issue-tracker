require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get ticket with good uid" do
    ticket=Ticket.first
    get :show, uid: ticket.uid
    assert_response :success
  end
  
  test "should redirect get ticket with bad uid" do
    request.env["HTTP_REFERER"] = 'search?word=ABC'
    get :show, uid: 'ASD-123-ASD-123-ASA'
    assert_response :redirect
  end
  
  test "should create new ticket" do
    ticket =  {
      customer_name: 'test customer',
      customer_email: 'test@test.com',
      subject: 'this is a test subject',
      body: 'test question',
      department_id: 1
    }
    oldcount = Ticket.count
    post :create, ticket: ticket
    assert_response :redirect
    assert Ticket.count > oldcount
  end
  
  test "should change ticket status" do
    status = 2
    post :change_status,{ticket_id: 4, status_id: status}
    assert_response :success
    assert Ticket.find(4).ticket_status_id == status
  end
end
