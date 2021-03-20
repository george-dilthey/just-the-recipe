require_relative '../environment.rb'

class JustTheRecipe::CLI

    def call
        puts "Welcome to Just the Recipe! What would you like to do? (enter a number 1-3)"
        list_options
        choose_option
    end

    def list_options
        puts "1. Search for a new recipe."
        puts "2. Get an All Recipes recipe from a url."
        puts "3. View your cookbook."
    end

    def choose_option
        input = gets.chomp
        if input == "1"
            puts "Chose option 1!"
        elsif input == "2"
            puts "Chose option 2!"
        elsif input == "3"
            JustTheRecipe::Recipe.display_cookbook
        else
            puts "Choose a number 1-3."
            choose_option
        end
    end

end