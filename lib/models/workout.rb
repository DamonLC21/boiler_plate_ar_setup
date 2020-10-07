class Workout < ActiveRecord::Base
  has_many :gym_sessions
  has_many :members, through: :gym_sessions

end