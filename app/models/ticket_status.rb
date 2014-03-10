class TicketStatus < ActiveRecord::Base
  has_many :tickets
  has_many :ticket_histories
  def self.get_to_select
    statuses = []
    self.all.map { |ticket_status| statuses << {id: ticket_status.id.to_s, name: ticket_status.name}}
    return statuses;
  end
end
