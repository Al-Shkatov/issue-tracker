class Ticket < ActiveRecord::Base
  attr_accessor :user_id
  before_create :generate_uid, :default_status
  after_save  :save_history
  
  validates :customer_name, presence: true, length: {in: 3..50}
  validates :customer_email, presence: true, 
                              length: {in: 6..50},
                              format: {with:/[a-z0-9\-\_\.]{3,30}@[a-z0-9\-\_\.]{3,30}\.[a-z]{2,6}/i}
  validates :subject, presence:true, length: {in: 3..50}
  validates :department_id, numericality: {greater_than: 0, only_integer: true}
  validates :body, presence:true, length: {in: 10..500}
  
  has_many :ticket_histories
  has_many :ticket_comments
  has_one :ticket_status
  has_one :department

  
  private
  def save_history
    history = TicketHistory.new({
        'ticket_id'=>self.id,
        'user_id'=>self.user_id,
        'ticket_status_id'=>self.ticket_status_id
      })
    history.save()
  end
  
  def default_status
    self.ticket_status_id = Setting.get :default_ticket_status if self.ticket_status_id.nil?
  end
  
  def generate_uid
    self.uid=chars(3)+'-'+numbers(3)+'-'+chars(3)+'-'+numbers(3)+'-'+chars(3) if self.uid.nil?
  end
  def chars(len)
    ('A'..'Z').to_a.shuffle[0,len].join.to_s
  end
  def numbers(len)
    val=''
    (len).to_i.times{val<<rand(9).to_s}
    val.to_s
  end
end
