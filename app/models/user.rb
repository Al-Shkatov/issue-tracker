class User < ActiveRecord::Base
  has_many :ticket_histories
  has_many :ticket_comments
end
