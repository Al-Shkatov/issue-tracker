class AddFkToTicketHistory < ActiveRecord::Migration
  def up
    execute <<-SQL
          ALTER TABLE ticket_histories
            ADD CONSTRAINT fk_ticket_id
            FOREIGN KEY (ticket_id)
            REFERENCES tickets(id)
            ON UPDATE CASCADE ON DELETE CASCADE,

            ADD CONSTRAINT fk_user_id
            FOREIGN KEY (user_id)
            REFERENCES users(id)
            ON UPDATE CASCADE ON DELETE SET NULL,

            ADD CONSTRAINT fk_ticket_status_id
            FOREIGN KEY (ticket_status_id)
            REFERENCES ticket_statuses(id)
            ON UPDATE CASCADE ON DELETE SET NULL;
    SQL
  end
  def down
    execute <<-SQL
          ALTER TABLE ticket_histories
            DROP FOREIGN KEY fk_ticket_id, DROP FOREIGN KEY fk_user_id, DROP FOREIGN KEY fk_ticket_status_id
    SQL
  end
end