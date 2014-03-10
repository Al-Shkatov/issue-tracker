class TicketComment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :parent_comment, class_name: 'TicketComment', foreign_key: 'parent_id'
  has_many :comments, class_name: 'TicketComment', foreign_key: 'parent_id'
  validates :body, presence: true, length:{in:5..500}
  
  def self.parent_comments
    self.where('parent_id = ?', 0).all
  end
end
