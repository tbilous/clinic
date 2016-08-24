class CreateAnthropometries < ActiveRecord::Migration
  def change
    create_table :anthropometries do |t|
      t.datetime :date, null: false, default: DateTime.now
      t.string  :comment
      t.float   :weight
      t.float   :height
      t.float   :cranium
      t.float   :chest
      t.integer :user_id, null: false
      t.integer :character_id, null: false

      t.timestamps null: false
    end
    add_index :anthropometries, [:user_id,  :created_at]
  end
end
