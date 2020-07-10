require 'pry'
require 'tty-prompt'
ActiveRecord::Base.logger = nil
class Cli

  $prompt = TTY::Prompt.new

  def welcome
    puts "Welcome to GitFit, your personal workout tracking app!"
  end

  def new_member
    new_member = Member.create_new
    puts "Nice to meet you #{new_member.name}! GitFit is here to help you #{new_member.goal.remove("I want to ")}"
    puts "Please note your member ID: #{new_member.id}. You will need it to sign in later!"
    sign_in
  end

  def see_member_profile
    Member.see_member_profile
  end

  def end_app
    puts "See you next time!"
  end

  def edit_member_profile
    menu = $prompt.select("What would you like to update?") do |menu|
      menu.choice 'Name'
      menu.choice 'Goal'
    end
    case menu
    when 'Name'
      new_name = Member.ask_for_name
      $signed_in_member.update(:name=>new_name)
    when 'Goal'
      new_goal = Member.ask_for_goal
      $signed_in_member.update(:goal=>new_goal)
    end
  end

  def delete_member_profile
    $signed_in_member.destroy
    puts "Your profile has been deleted"
    end_app
  end

  def workout
    bar = TTY::ProgressBar.new("Work out in progress [:bar]", total: 30)
    30.times do
      sleep(0.1)
      bar.advance(1)
    end
    puts "Great job! You finished your workout."
  end

  def display_member_menu
    member_menu = $prompt.select("Member Menu") do |menu|
      menu.choice 'See member profile'
      menu.choice 'Edit member profile'
      menu.choice 'Select your workout'
      menu.choice 'Delete member profile'
      menu.choice 'Exit GitFit'
    end
    member_menu
  end

  def navigate_member_menu
    loop do
      case display_member_menu
        when 'See member profile'
        see_member_profile
        when 'Edit member profile'
        edit_member_profile
        when 'Select your workout'
          select_type_of_workout
          workout
        when 'Delete member profile'
          delete_member_profile
          break
        when 'Exit GitFit'
          end_app
          break
        end
    end
  end

  def create_or_sign_in
    menu = $prompt.select("Please sign in or create a new account.") do |menu|
      menu.choice 'Build new profile'
      menu.choice 'Sign in'
      menu.choice 'Exit GitFit'
    end
    menu
  end

  def select_type_of_workout 
    answer = $prompt.select("Choose your workout") do |menu|
      menu.choice 'Full Body'
      menu.choice 'Chest'
      menu.choice 'Back'
      menu.choice 'Legs'
      menu.choice 'Arms'
    end
    puts "You have selected a #{answer} workout."
    new_session = GymSession.create()
    new_workout = Workout.find_or_create_by(:body_part=>answer)
    new_workout.gym_sessions << new_session
    $signed_in_member.gym_sessions << new_session
  end

  def sign_in
    puts "Please enter your member ID."
    member_id = gets.chomp
    if Member.find_by id: member_id
      $signed_in_member = Member.find_by id: member_id
    else
      puts "You have entered an incorrect member ID"
      exit! if create_or_sign_in == "Exit GitFit"
    end
  end
end