class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |element|
      element.string :name
      element.integer :user_id
    end
  end
end
