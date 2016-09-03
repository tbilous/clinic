class CreateAnthropometries < ActiveRecord::Migration
  def change
    create_table :anthropometries do |t|
      t.integer :character_id, null: false

      t.date :date, null: false, default: DateTime.now.to_date
      t.string  :comment
      t.float   :weight
      t.float   :height
      t.float   :cranium
      t.float   :chest

      t.timestamps null: false
    end
    add_index :anthropometries, [:character_id, :created_at]
  end
end
