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
        puts "2. Get a recipe from a url."
        puts "3. View your cookbook."
    end

    def choose_option
        input = nil
        puts  "Enter a number 1-3 or type exit."
        while input != "exit"
            input = gets.chomp
            if input == "1"
                search
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
        puts "Enter your url:"
        url = gets.chomp
        if JustTheRecipe::Scraper.new(url).valid_url?
            recipe = JustTheRecipe::Scraper.new(url).get_recipe_by_schema
            recipe.display_recipe
            add_recipe(recipe)
            list_options
        else
            puts ""
            puts "Sorry, it doesn't look like we can get the recipe from that URL. Try something else."
            list_options
        end
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

    def search
        puts "Enter your search term:"
        search_term = gets.chomp
        recipe = JustTheRecipe::Searcher.new(search_term).api_get
        if recipe.class == JustTheRecipe::Recipe
            recipe.display_recipe
            add_recipe(recipe)
            list_options
        else
            list_options
        end
    end



    def goodbye
        puts "Thanks for stopping by!"
    end

end