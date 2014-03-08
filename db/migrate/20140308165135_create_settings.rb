class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :scope
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
