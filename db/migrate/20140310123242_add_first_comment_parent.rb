#needed to work fk on itself
class AddFirstCommentParent < ActiveRecord::Migration
  def up
    execute 'SET sql_mode="NO_AUTO_VALUE_ON_ZERO"'
    execute 'INSERT INTO ticket_comments(id) VALUES(0);'
    execute 'SET sql_mode="";'
  end
  def down
    execute 'DELETE FROM ticket_comments'
  end
end
