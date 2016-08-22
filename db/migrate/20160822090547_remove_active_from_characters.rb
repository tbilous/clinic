class RemoveActiveFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :active, :boolean
  end
end
