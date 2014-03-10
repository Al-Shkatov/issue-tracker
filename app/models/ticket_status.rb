class TicketStatus < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_history
  def self.get_to_select
    statuses = []
    self.all.map { |ticket_status| statuses << {id: ticket_status.id.to_s, name: ticket_status.name}}
    return statuses;
  end
end
