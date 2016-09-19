class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :pharms, :pharmowner_id, :pharm_owner_id
  end
end
