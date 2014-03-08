class TicketHistory < ActiveRecord::Base
  belongs_to :ticket_id
  belongs_to :user_id
  belongs_to :ticket_status_id
end
