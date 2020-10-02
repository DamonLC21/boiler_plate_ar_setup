require_relative 'config/environment'

# require_relative 'lib/seeds.rb'

# Cli.new.start_game

# binding.pry

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

app = Cli.new

app.welcome
app.get_name
app.create_new_user 
app.first_prompt
app.add_selected_song_to_liked_songs

# app.view_my_liked_songs

binding.pry
binding.pry

# app.recommend_song
app.create_new_playlist



app.sad_song_list


