class CreatePharmTypes < ActiveRecord::Migration
  def change
    create_table :pharm_types do |t|
      t.integer   :user_id, null: false

      t.string    :name, null: false
      t.string    :slug, null: false
      t.text      :comment

      t.timestamps null: false
    end
    add_index :pharm_types, [:user_id]
  end
end
