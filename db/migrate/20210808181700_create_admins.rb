class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :role
      t.string :email
      t.integer :mobile

      t.timestamps
    end
  end
end
