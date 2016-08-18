class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string  :name,      null: false
      t.string  :comment,   default: ""
      t.date    :birthday,  null: false
      t.boolean :sex,       null: false
      t.boolean :active,    default: false
      t.boolean :usd,       default: true
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :characters, [:user_id, :created_at]
  end
end
