class AddFkToTicketComments < ActiveRecord::Migration
  def up
    execute <<-SQL
          ALTER TABLE ticket_comments
            ADD CONSTRAINT ticket_id
            FOREIGN KEY (ticket_id)
            REFERENCES tickets(id)
            ON UPDATE CASCADE ON DELETE CASCADE,

            ADD CONSTRAINT user_id
            FOREIGN KEY (user_id)
            REFERENCES users(id)
            ON UPDATE CASCADE ON DELETE SET NULL,

            ADD CONSTRAINT parent_id
            FOREIGN KEY (parent_id)
            REFERENCES ticket_comments(id)
            ON UPDATE CASCADE ON DELETE CASCADE;
    SQL
  end
  def down
    execute <<-SQL
          ALTER TABLE ticket_comments
            DROP FOREIGN KEY ticket_id, DROP FOREIGN KEY user_id, DROP FOREIGN KEY parent_id
    SQL
  end
end
