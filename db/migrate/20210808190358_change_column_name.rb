class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :mobile_number, :mobile
  end
end
