class TicketStatus < ActiveRecord::Base
  belongs_to :ticket
  belocngs_to :ticket_history
end
