require 'test_helper'

class CustomerCanCreateAndFindTicketsTest < ActionDispatch::IntegrationTest
  fixtures :all
  test "customer create new ticket and shown it" do
    get '/tickets/new'
    post_via_redirect '/tickets', ticket: {
      customer_name: 'test customer',
      customer_email: 'test@test.com',
      subject: 'this is a test subject',
      body: 'test question',
      department_id: 1
    }
    message = flash[:success]
    match = message.match(/([A-Z]{3}\-\d{3}\-){2}[A-Z]{3}/)
    assert_not_nil match, 'flash message has uid'
    
    uid = match[0]
    assert_equal '/ticket/'+uid.to_s, path, 'redirect to required url(ticket_uid_path)'
    
    assert_not_nil Ticket.find_by_uid(uid), 'new ticket added to db'
  end
  test "customer can find ticket" do
    get '/'
    post_via_redirect 'search', word: 'ABC-123-ABC-123-ABC'
    assert_equal '/search', path
    tickets = assigns(:tickets)
    assert tickets
    assert_equal tickets[0].uid, 'ABC-123-ABC-123-ABC'
  end
end
