require_relative '../spec_helper'
 
describe TicketNotify do
  describe 'new_ticket' do
    let(:ticket) { mock_model Ticket, 
      uid: 'ABC-123-ABC-123-ABC', 
      customer_name: 'Lucas', 
      customer_email: 'lucas@email.com',
      subject: 'test subject',
      body: 'test question',
      ticket_status_id: 1,
      department_id: 1
    }
    let(:mail) { TicketNotify.new_ticket(ticket) }
 
    it 'renders the subject' do
      mail.subject.should == 'You create new ticket ABC-123-ABC-123-ABC'
    end
 
    it 'renders the receiver email' do
      mail.to.should == [ticket.customer_email]
    end
 
    it 'renders the body has ticket UID' do
      mail.body.encoded.should match("ABC-123-ABC-123-ABC")
    end
    it 'renders the body has ticket_uid_path' do
      mail.body.encoded.should match("http://localhost/ticket/ABC-123-ABC-123-ABC")
    end
  end
  
  describe 'changes_in_ticket' do
    let(:ticket) { mock_model Ticket, 
      id: 5,
      uid: 'ABC-123-ABC-123-ABC', 
      customer_name: 'Lucas', 
      customer_email: 'lucas@email.com',
      subject: 'test subject',
      body: 'test question',
      ticket_status_id: 1,
      department_id: 1
    }
    let(:comment) {mock_model TicketComment,
      ticket_id: 5,
      user_id: 1,
      parent_id: 0,
      body: 'this a test comment'
    }
    let(:mail) { TicketNotify.changes_in_ticket(ticket, comment) }
    
    it 'has comment part' do
      mail.body.encoded.should match("test comment")
    end
    
    it 'has link to ticket' do
      mail.body.encoded.should match("http://localhost/ticket/ABC-123-ABC-123-ABC")
    end
    
    it 'sent to ticket creator' do
      mail.to.should == [ticket.customer_email]
    end
  end
end