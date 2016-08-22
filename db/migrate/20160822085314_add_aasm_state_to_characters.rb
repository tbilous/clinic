class AddAasmStateToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :aasm_state, :string
  end
end
