class User < ActiveRecord::Base
  require 'digest/md5'
  
  has_many :ticket_histories
  has_many :ticket_comments
  
  def self.auth(login, password)
    self.find_by_login_and_password(login, Digest::MD5.hexdigest(password))
  end
end
