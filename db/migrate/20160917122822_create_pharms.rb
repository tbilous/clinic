class CreatePharms < ActiveRecord::Migration
  def change
    create_table :pharms do |t|
      t.integer   :user_id, null: false

      t.string    :name, null: false
      t.text      :comment, null: false
      t.string    :attention

      t.float     :dose, null: false
      t.float     :volume, null: false

      t.integer   :type_id, null: false
      t.integer   :pharmowner_id, null: false

      t.timestamps null: false
    end

    add_index :pharms, [:user_id, :pharmowner_id]
  end
end
