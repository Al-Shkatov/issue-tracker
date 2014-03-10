class TicketComment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :parent_comment, class_name: 'TicketComment', foreign_key: 'parent_id'
  has_many :comments, class_name: 'TicketComment', foreign_key: 'parent_id'
  
  def self.parent_comments
    self.where('parent_id = ?', 0).all
  end
end
