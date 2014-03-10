require 'rubygems'
require 'faker'
require 'active_record'

ActiveRecord::Base.establish_connection(
  host: :localhost,
  adapter: :mysql2,
  database: :issue_tracker_dev,
  port: 3306,
  username: :root,
  password: :astarta,
)


class Ticket < ActiveRecord::Base
  
end

def generate_uid
  chars(3)+'-'+numbers(3)+'-'+chars(3)+'-'+numbers(3)+'-'+chars(3)
end
def chars(len)
  ('A'..'Z').to_a.shuffle[0,len].join.to_s
end
def numbers(len)
  val=''
  (len).to_i.times{val<<rand(9).to_s}
  val.to_s
end


10000.times do |index|
  ticket = Ticket.new(
    {
      uid: generate_uid,
      customer_name: Faker::Name.name,
      customer_email: Faker::Internet.email,
      subject: Faker::Lorem.words(3+rand(3)),
      body: Faker::Lorem.paragraphs(1+rand(2)),
      department_id: 1+rand(2),
      ticket_status_id: 1+rand(4)
    }
  )
  ticket.save
end

