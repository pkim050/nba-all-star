class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |element|
      element.string :username
      element.string :email
      element.string :password_digest
    end
  end
end
