class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :ticket

      t.string :text
      t.boolean :reply

      t.timestamps
    end

    add_index :comments, :ticket_id, unique: false
  end
end
