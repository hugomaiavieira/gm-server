class CreateSpents < ActiveRecord::Migration
  def change
    create_table :spents, id: false do |t|
      t.string :id, primary_key: true
      t.float :amount
      t.string :description
      t.date :date
      t.string :category_id
      t.references :user

      t.timestamps
    end

    add_index :spents, :user_id
    add_index :spents, :category_id
    add_index :spents, :id, :unique => true
  end
end
