class CreatePharmOwners < ActiveRecord::Migration
  def change
    create_table :pharm_owners do |t|
      t.integer   :user_id, null: false

      t.string    :name, null: false
      t.text      :comment

      t.timestamps null: false
    end
    add_index :pharm_owners, [:user_id]
  end
end
