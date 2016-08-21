class AddPhotoUidToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :photo_uid, :string
  end
end
