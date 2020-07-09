class CreateGymSessions < ActiveRecord::Migration[6.0]

  def change
    create_table :gym_sessions do |t|
      t.references :member
      t.references :workout
    end
  end
end