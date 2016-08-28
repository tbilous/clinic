class AddPatientToUsers < ActiveRecord::Migration
  def change
    add_column :users, :patient, :integer
  end
end
