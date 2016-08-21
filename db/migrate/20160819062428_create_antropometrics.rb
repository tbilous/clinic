class CreateAntropometrics < ActiveRecord::Migration
  def change
    create_table :antropometric do |t|
      t.datetime      :date,          null: false, default: DateTime.now
      t.text          :comment
      t.float         :weight
      t.float         :height
      t.float         :cranium
      t.float         :chest
      t.integer       :character_id,  null: false
      
      t.timestamps null: false
    end
    add_index :antropometric, [:created_at, :character_id]
  end
end
