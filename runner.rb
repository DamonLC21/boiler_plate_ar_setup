require_relative 'config/environment'

# Cli.new.start_game

# binding.pry

app = Cli.new

app.welcome
app.get_name 
app.get_user_mood
app.recommend_song

binding.pry 