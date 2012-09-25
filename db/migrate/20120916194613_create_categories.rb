class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.references :user

      t.timestamps
    end

    add_index :categories, :id, :unique => true
  end
end
