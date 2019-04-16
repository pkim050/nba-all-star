class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |element|
      element.string :name
      element.string :position
      element.boolean :captain, default: false
      element.integer :team_id
    end
  end
end
