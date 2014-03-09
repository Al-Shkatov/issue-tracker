class TicketComment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :parent_comment, class_name: 'TicketComment', foreign_key: 'parent_id'
  has_manu :comment, class_name: 'TicketComment', foreign_key: 'parent_id'
end
