class Cli
    def welcome
        system 'clear'
        puts "Hello"
    end 

    def get_name
        prompt = TTY::Prompt.new 
        @username = prompt.ask("Enter your name:")
    end 

    def get_user_mood
        prompt = TTY::Prompt.new
        @user_selection = prompt.select("Welcome #{@username}. Enter your mood", %w(Happy Sad Motivated Carefree Love))
    end 

    def sad_song
        lyrics = Song.select{|song| song[:lyrics] == 'sad'}
        puts lyrics.title  
    end 

    def recommend_song
            if @user_selection == "Sad"
            puts 'These are some sad songs for you to listen to:'
            sad_song
        end 
    end




     

end 