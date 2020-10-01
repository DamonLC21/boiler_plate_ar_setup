class Cli
    def welcome
        system 'clear'
        puts "Hello"
    end 

    def prompt
        prompt = TTY::Prompt.new
        prompt.select("Enter your mood", %w(Happy Sad Motivated Carefree Love))
    end 

    def recommend_songs
        if prompt 

    end 




     

end 