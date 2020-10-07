require 'pry'
require 'tty-prompt'

ActiveRecord::Base.logger = nil
class Cli

  $prompt = TTY::Prompt.new
  $pastel = Pastel.new
  TTY::Screen.size
  
  font = TTY::Font.new(:doom)
  puts $pastel.cyan.bold(font.write("GitFit", letter_spacing: 4))

  def welcome
    puts $pastel.green.bold("Welcome to GitFit, your personal workout tracking app!")
  end

  def new_member
    new_member = Member.create_new
    puts $pastel.yellow("Nice to meet you #{new_member.name}! GitFit is here to help you #{new_member.goal.remove("I want to ")}")
    puts $pastel.yellow("Please note your member ID:" + " " + $pastel.red("#{new_member.id}.") + " " + $pastel.yellow.bold("You will need it to sign in later!"))
    sign_in
  end

  def see_member_profile
    Member.see_member_profile
  end

  def end_app
    puts $pastel.red("See you next time!")
  end

  def edit_member_profile
    menu = $prompt.select($pastel.yellow("What would you like to update?")) do |menu|
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
    puts $pastel.red("Your profile has been deleted")
    end_app
  end

  def workout
    bar = TTY::ProgressBar.new($pastel.green("Work out in progress [:bar]"), total: 30)
    30.times do
      sleep(0.1)
      bar.advance(1)
    end
    puts $pastel.green("Great job! You finished your workout.")
  end

  def display_member_menu
    member_menu = $prompt.select($pastel.yellow("Member Menu")) do |menu|
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
    menu = $prompt.select($pastel.yellow("Please sign in or create a new account.")) do |menu|
      menu.choice 'Build new profile'
      menu.choice 'Sign in'
      menu.choice 'Exit GitFit'
    end
    menu
  end

  def select_type_of_workout 
    answer = $prompt.select($pastel.yellow("Choose your workout")) do |menu|
      menu.choice 'Full Body'
      menu.choice 'Chest'
      menu.choice 'Back'
      menu.choice 'Legs'
      menu.choice 'Arms'
      menu.choice 'Back to menu'
    end
    if answer === 'Back to menu'
      navigate_member_menu
    else
    workout_type = ''
      if $signed_in_member.goal == 'I want to lose weight.'
        workout_type = 'Hypertrophy'
      else
        workout_type = "Strength"
      end
      puts $pastel.yellow("You have selected a #{answer} workout.")
      new_session = GymSession.create()
      new_workout = Workout.find_or_create_by(:body_part => answer, :kind_of_workout => workout_type)
      new_workout.gym_sessions << new_session
      $signed_in_member.gym_sessions << new_session
    end
  end

  def sign_in
    puts $pastel.yellow("Please enter your member ID.")
    member_id = gets.chomp
    if Member.find_by id: member_id
      $signed_in_member = Member.find_by id: member_id
    else
      puts $pastel.bright_red("You have entered an incorrect member ID")
      if create_or_sign_in == "Exit GitFit"
        end_app
        exit!
      elsif create_or_sign_in == "Sign in"
        sign_in
      end
    end
  end
end