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
        puts "2. Get an AllRecipes recipe from a url."
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
                scrape_url
            elsif input == "3"
                JustTheRecipe::Recipe.display_cookbook
                list_options
            elsif input == "exit"
                break
            elsif input == "options"
                list_options
            else
                puts "Whoops! Choose a number 1-3, type options to view your options again, or type exit."
            end
        end
    end

    def scrape_url
        puts "Enter your AllRecipes url:"
        url = gets.chomp
        recipe = JustTheRecipe::Scraper.new(url).get_recipe_by_schema
        recipe.display_recipe
        add_recipe(recipe)
        list_options
    end

    def add_recipe(recipe)
        puts "Would you like to add this recipe to your cookbook? (y/n)"
        input = gets.chomp
        if input == "y"
            puts "Ok! I'll add this recipe to your cookbook."
            recipe.add_to_cookbook
        elsif input == "n"
            puts "No problem. This recipe wasn't added to your cookbook."
        else 
            puts "Sorry, you'll have to answer with either 'y' or 'n'."
        end
    end



    def goodbye
        puts "Thanks for stopping by!"
    end

end