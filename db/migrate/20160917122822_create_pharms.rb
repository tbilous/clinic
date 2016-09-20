class CreatePharms < ActiveRecord::Migration
  def change
    create_table :pharms do |t|
      t.integer   :user_id, null: false

      t.string    :name, null: false
      t.text      :comment, null: false
      t.string    :attention

      t.float     :dose, null: false
      t.float     :volume, null: false

      t.integer   :pharm_type_id
      t.integer   :pharm_owner_id

      t.timestamps null: false
    end

    add_index :pharms, [:user_id]
  end
end
