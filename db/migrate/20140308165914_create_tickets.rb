class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :uid
      t.string :customer_name
      t.string :customer_email
      t.string :subject
      t.text :body
      t.references :ticket_status, index: true
      t.references :department, index: true

      t.timestamps
    end
  end
end
