require_relative '../environment.rb'

class JustTheRecipe::CLI

    def call
        JustTheRecipe::Cookbook.create_from_files
        puts "Welcome to Just the Recipe! What would you like to do?"
        main_menu
    end

    def list_options
        puts  "\n\nEnter a number 1-3 or type exit."
        puts "1. Search for a new recipe."
        puts "2. Get a recipe from a url."
        puts "3. View your cookbooks."
    end

    def main_menu
        prompt = TTY::Prompt.new
        puts "\n"
        menu_choice = prompt.select("Choose an option") do |menu|
            menu.choice name: "Search for a new recipe.", value: 1
            menu.choice name: "Get a recipe from a URL.", value: 2
            menu.choice name: "View your cookbooks.", value: 3
            menu.choice name: "Exit", value: "exit"
        end

        case menu_choice
        when 1
            search
        when 2
            scrape_url
        when 3
            cookbook_menu 
        when "exit"
            goodbye
        end
    end

    def scrape_url
        puts "Enter your url:"
        url = gets.chomp
        if JustTheRecipe::Scraper.new(url).valid_url?
            recipe = JustTheRecipe::Scraper.new(url).get_recipe_by_schema
            recipe.display_recipe
            add_recipe(recipe)
            main_menu
        else
            puts ""
            puts "Sorry, it doesn't look like we can get the recipe from that URL. Try something else."
            main_menu
        end
    end

    def add_recipe(recipe)
        puts "Would you like to add this recipe to a cookbook? (y/n)"
        input = gets.chomp
        if input == "y"
            puts "Ok! Which cookbook would you like to add this recipe to? Type an existing cookbook name, or type anything to create a new one!"
            cookbook = gets.chomp
            recipe.add_to_cookbook(cookbook)
            puts "Great choice. We added this recipe to the cookbook called #{cookbook}"
        elsif input == "n"
            puts "No problem. This recipe wasn't added to a cookbook."
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
            main_menu
        else
            main_menu
        end
    end

    def cookbook_menu
        prompt = TTY::Prompt.new
     
        cookbooks_create = JustTheRecipe::Cookbook.list_cookbooks << "Create a new cookbook" << "Delete" << "Exit"
        input = prompt.select("Choose a cookbook to view or create a new one.", cookbooks_create)  
        JustTheRecipe::Cookbook.list_cookbooks
       
        if JustTheRecipe::Cookbook.find_by_name(input)
            puts "Here's what's in the cookbook called #{input}:" 
            puts JustTheRecipe::Cookbook.find_by_name(input).return_cookbook
            main_menu
        elsif input == "Create a new cookbook"
            puts "Ok! What would you like to name your new cookbook?"
            cookbook = gets.chomp
            JustTheRecipe::Cookbook.new(cookbook)
            puts "Great! We created a new cookbook for you. Find some recipes to add to it!"
            main_menu
        elsif input == "Delete"
            puts "Which cookbook would you like to delete? WARNING: THIS CANNOT BE UNDONE!\n\n"
            JustTheRecipe::Cookbook.list_cookbooks
            delete_cookbook = gets.chomp
            JustTheRecipe::Cookbook.delete(delete_cookbook)
            puts "Ok, we deleted that cookbook."
            main_menus
        elsif input == "Exit"
            main_menu
        else 
            puts ""
            puts "Sorry, thats not a valid cookbook. Type \"create\" to create a new cookbook or type \"exit\" to return to the main menu"
            cookbook_menu
        end
    end

    def goodbye
        puts "\n\nThanks for stopping by! If you created any cookbooks, they'll be saved as text files so that you can continue using them in the future. See you soon!"
    end

end