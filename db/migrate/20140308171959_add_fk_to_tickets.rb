class AddFkToTickets < ActiveRecord::Migration
  def up
    execute <<-SQL
          ALTER TABLE tickets
            ADD CONSTRAINT ticket_status_id
            FOREIGN KEY (ticket_status_id)
            REFERENCES ticket_statuses(id)
            ON UPDATE CASCADE ON DELETE RESTRICT,

            ADD CONSTRAINT department_id
            FOREIGN KEY (department_id)
            REFERENCES departments(id)
            ON UPDATE CASCADE ON DELETE RESTRICT;
    SQL
  end
  def down
    execute <<-SQL
          ALTER TABLE tickets
            DROP FOREIGN KEY ticket_status_id, DROP FOREIGN KEY department_id
    SQL
  end
end
