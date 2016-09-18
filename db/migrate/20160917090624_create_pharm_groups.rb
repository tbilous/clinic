class CreatePharmGroups < ActiveRecord::Migration
  def change
    create_table :pharm_groups do |t|
      t.integer   :user_id, null: false

      t.string    :name, null: false
      t.text      :comment

      t.timestamps null: false
    end
    add_index :pharm_groups, [:user_id]
  end
end
