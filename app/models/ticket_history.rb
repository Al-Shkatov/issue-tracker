class TicketHistory < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  has_one :ticket_status
end
