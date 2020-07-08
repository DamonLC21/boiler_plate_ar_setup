class Member < ActiveRecord::Base
  has_many :gym_sessions
  has_many :workouts, through: :gym_sessions
end