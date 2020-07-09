require 'pry'
require 'tty-prompt'

class Member < ActiveRecord::Base
  $prompt = TTY::Prompt.new
  has_many :gym_sessions
  has_many :workouts, through: :gym_sessions

  def self.create_new
    puts "What is your name"
    name = gets.chomp
    goal = $prompt.select("What is your goal") do |menu|
      menu.choice 'I want to lose weight'
      menu.choice 'I want to gain strength'
    end
    new_member = Member.create(:name=>name, :goal=>goal)
    puts "Nice to meet you #{name}! GitFit is here to help you #{goal.remove("I want to ")}!"
    puts "Please note your member ID: #{new_member.id}. You will need it to view your profile and log workouts later!"
  end

  def self.see_user_profile
    member = self.sign_in
    puts "Name: #{member[:name]}"
    puts "Goal: #{member[:goal]}"
    puts "Workouts completed: #{self.get_user_workouts member}"
  end

  def self.sign_in
    puts "Please enter your member ID"
    member_id = gets.chomp
    found_member = self.find_by id: member_id
    found_member
  end

  def self.get_user_workouts member
    workout_array = member.workouts.map do |workout|
      workout.body_part
    end
    hash = {}
    workout_array.each do |value|
      hash[value] ? hash[value] += 1 : hash[value] = 1
    end
    hash
  end
end
