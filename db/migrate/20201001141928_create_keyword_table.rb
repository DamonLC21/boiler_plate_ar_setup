class CreateKeywordTable < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |table|
      table.string :mood
    end 
  end
end
