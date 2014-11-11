class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :user
      t.string :token

      t.string :customer_name
      t.string :customer_email

      t.integer :department
      t.string :subject
      t.string :description

      t.integer :status, default: 0

      t.timestamps
    end

    add_index :tickets, :user_id, unique: false
    add_index :tickets, :subject, unique: false
    add_index :tickets, :department, unique: false
    add_index :tickets, :status, unique: false
  end
end
