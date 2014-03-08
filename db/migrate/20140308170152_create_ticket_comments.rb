class CreateTicketComments < ActiveRecord::Migration
  def change
    create_table :ticket_comments do |t|
      t.references :ticket, index: true
      t.references :user, index: true
      t.references :parent, index: true
      t.text :comment

      t.timestamps
    end
  end
end
