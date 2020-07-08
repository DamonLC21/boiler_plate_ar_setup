Workout.delete_all
Member.delete_all
GymSession.delete_all

michael = Member.create(:name=>"Michael", :goal=>"strength")
derek = Member.create(:name=>"Derek", :goal=>"Weight Loss")
gordo = Member.create(:name=>"Gordo", :goal=>"strength")

chest_workout = Workout.create(:body_part=>"Chest")
back_workout = Workout.create(:body_part=>"back")
arms_workout = Workout.create(:body_part=>"arms")

session1 = GymSession.create(:name=>"First of day")
session2 = GymSession.create(:name=>"2nd of day")
session3 = GymSession.create(:name=>"3rd of day")

session1.member = michael
session2.member = derek
session3.member = gordo

michael.gym_sessions << session1
gordo.gym_sessions << session3
derek.gym_sessions << session2

chest_workout.gym_sessions << session1
back_workout.gym_sessions << session2
arms_workout.gym_sessions << session3

