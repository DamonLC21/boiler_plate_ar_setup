require 'tty-prompt'
class Cli

  $prompt = TTY::Prompt.new

  def welcome
    puts "Welcome to GitFit, your personal workout generator!"
  end

  def new_member
    Member.create_new
  end

  def see_user_profile
    Member.see_user_profile
  end

  def sign_in
    Member.sign_in
  end

  def end_app
    puts "See you next time!"
  end

  def workout
    bar = TTY::ProgressBar.new("Work out in progress [:bar]", total: 30)
    30.times do
      sleep(0.1)
      bar.advance(1)
    end
    puts "Great job! You finished your workout."
  end

  def main_menu
    main_menu = $prompt.select("Main Menu") do |menu|
      menu.choice 'Build new profile'
      menu.choice 'See member profile'
      menu.choice 'Select your workout'
      menu.choice 'Exit GitFit'
    end
    main_menu
  end




  def select_type_of_workout member
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
    member.gym_sessions << new_session
  end
end