class AddNameAndPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :phone_number, :string, null: false, default: ''
  end
end
