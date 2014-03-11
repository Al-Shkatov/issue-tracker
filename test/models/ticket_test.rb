require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "create ticket only with valid data" do
    ticket = Ticket.new
    assert ticket.invalid?, 'cant create ticket without attributes'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_email: 'test@test.com',
        subject: 'this is a test subject',
        body: 'test question',
        department_id: 1,
        ticket_status_id: 1
      })
    assert ticket.invalid?, 'cant create ticket without customer'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_name: 'test customer',
        customer_email: 'test/test.com',
        subject: 'this is a test subject',
        body: 'test question',
        department_id: 1,
        ticket_status_id: 1
      })
    assert ticket.invalid?, 'cant create ticket with invalid email'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_name: 'test customer',
        customer_email: 'test@test.com',
        subject: 'this is a test subject',
        body: 'test question',
        ticket_status_id: 1
      })
    assert ticket.invalid?, 'cant create ticket without department'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_name: 'test customer',
        customer_email: 'test@test.com',
        body: 'test question',
        department_id: 1,
        ticket_status_id: 1
      })
    assert ticket.invalid?, 'cant create ticket without subject'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_name: 'test customer',
        customer_email: 'test@test.com',
        subject: 'this is a test subject',
        department_id: 1,
        ticket_status_id: 1
      })
    assert ticket.invalid?, 'cant create ticket without body'
    
    ticket = Ticket.new({
        uid: 'TTT-111-TTT-111-TTT',
        customer_name: 'test customer',
        customer_email: 'test@test.com',
        subject: 'this is a test subject',
        body: 'test question',
        department_id: 1,
        ticket_status_id: 1
      })
    assert ticket.valid?, 'all required attributes present and has required format'
  end
end
