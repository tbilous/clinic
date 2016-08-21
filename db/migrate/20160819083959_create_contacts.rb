class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer     :user_id,   null:false
      t.string      :name,      null:false
      t.text        :comment,   null:false
      t.text        :address,   null:false
      t.string      :phone,     null:false
      t.string      :email,     null:false
      t.float       :latitude
      t.float       :longitude
      t.string      :photo
      
      t.timestamps null: false
    end
    add_index :contacts, [:user_id, :created_at]
  end
end
