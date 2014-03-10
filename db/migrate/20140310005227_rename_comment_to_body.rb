class RenameCommentToBody < ActiveRecord::Migration
  def change
    rename_column :ticket_comments, :comment, :body
  end
end
