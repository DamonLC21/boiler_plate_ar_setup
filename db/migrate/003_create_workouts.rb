class CreateWorkouts < ActiveRecord::Migration[6.0]

  def change
    create_table :workouts do |t|
      t.string :body_part
      t.string :kind_of_workout
    end
  end
end