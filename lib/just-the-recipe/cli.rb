require_relative '../environment.rb'

class JustTheRecipe::CLI

    def call
        puts "Welcome to Just the Recipe! What would you like to do?"
        list_options
        choose_option
        goodbye
    end

    def list_options
        puts "1. Search for a new recipe."
        puts "2. Get an All Recipes recipe from a url."
        puts "3. View your cookbook."
    end

    def choose_option
        input = nil
        puts  "Enter a number 1-3 or type exit."
        while input != "exit"
            input = gets.chomp
            if input == "1"
                puts "Chose option 1!"
            elsif input == "2"
                puts "Chose option 2!"
            elsif input == "3"
                JustTheRecipe::Recipe.display_cookbook
            elsif input == "exit"
                break
            elsif input == "options"
                list_options
            else
                puts "Whoops! Choose a number 1-3, type options to view your options again, or type exit."
            end
        end
    end

    def goodbye
        puts "Thanks for stopping by!"
    end

end