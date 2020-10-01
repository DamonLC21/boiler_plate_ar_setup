class CreateUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |table|
      table.string :name
      table.integer :age
      table.string :mood
    end 
  end
end
