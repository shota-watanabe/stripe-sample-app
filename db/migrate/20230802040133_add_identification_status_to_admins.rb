class AddIdentificationStatusToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :identification_status, :integer, null: false, default: 0
  end
end
