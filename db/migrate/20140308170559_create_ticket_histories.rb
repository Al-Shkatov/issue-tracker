class CreateTicketHistories < ActiveRecord::Migration
  def change
    create_table :ticket_histories do |t|
      t.references :ticket, index: true
      t.references :user, index: true
      t.references :ticket_status, index: true

      t.timestamps
    end
  end
end
