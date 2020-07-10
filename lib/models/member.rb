require 'pry'
require 'tty-prompt'

class Member < ActiveRecord::Base
  $prompt = TTY::Prompt.new
  has_many :gym_sessions
  has_many :workouts, through: :gym_sessions

  def self.create_new
    name = self.ask_for_name
    goal = self.ask_for_goal
    Member.create(:name=>name, :goal=>goal)
  end

  def self.ask_for_name
    puts "What is your name?"
    gets.chomp
  end

  def self.ask_for_goal
    goal = $prompt.select("What is your goal?") do |menu|
      menu.choice 'I want to lose weight.'
      menu.choice 'I want to gain strength.'
    end
  end

  def self.see_member_profile
    if $signed_in_member
      $signed_in_member.reload
      puts "Name: #{$signed_in_member[:name]}"
      puts "Member ID: #{$signed_in_member[:id]}"
      puts "Goal: #{$signed_in_member[:goal]}"
      puts $signed_in_member.display_member_workouts_table
    else
      puts "This member ID does not exist."
      self.see_member_profile
    end
  end

  def display_member_workouts_table
    hash = {}
    workout_array = self.workouts.map(&:body_part)
    workout_array.each { |value| hash[value] ? hash[value] += 1 : hash[value] = 1 }
    table = TTY::Table.new ['Body Part','Workouts Completed'], hash.to_a
    table.render(:ascii)
  end
end
