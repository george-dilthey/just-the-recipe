require './lib/just-the-recipe.rb'

class JustTheRecipe::CLI

    def call
        JustTheRecipe::Cookbook.create_from_files
        puts "Welcome to Just the Recipe! What would you like to do?"
        main_menu
    end

    def main_menu
        prompt = TTY::Prompt.new
        puts "\n"
        menu_choice = prompt.select("Choose an option") do |menu|
            menu.choice name: "Search for a new recipe.", value: 1
            menu.choice name: "Get a recipe from a URL.", value: 2
            menu.choice name: "View your cookbooks.", value: 3
            menu.choice name: "Create a new recipe manually.", value: 4
            menu.choice name: "Exit", value: "exit"
        end

        case menu_choice
        when 1
            search
        when 2
            scrape_url
        when 3
            cookbook_menu
        when 4
            new_recipe 
        when "exit"
            goodbye
        end
    end

    def search
        puts "Enter your search term:"
        search_term = gets.chomp
        recipe = JustTheRecipe::Searcher.new(search_term).api_get
        if recipe.class == JustTheRecipe::Recipe
            recipe.display_recipe
            add_recipe(recipe)
        else
            main_menu
        end
    end

    def scrape_url
        puts "Enter your url:"
        url = gets.chomp
        if JustTheRecipe::Scraper.new(url).valid_url?
            recipe = JustTheRecipe::Scraper.new(url).get_recipe_by_schema
            recipe.display_recipe
            add_recipe(recipe)
        else
            puts "\nSorry, it doesn't look like we can get the recipe from that URL. Try something else."
            main_menu
        end
    end

    def cookbook_menu
        prompt = TTY::Prompt.new
     
        cookbooks_create = JustTheRecipe::Cookbook.list_cookbooks << "Create a new cookbook." << "Delete a cookbook." << "Main Menu"
        input = prompt.select("Choose a cookbook to view or create a new one.", cookbooks_create)  
        JustTheRecipe::Cookbook.list_cookbooks
       
        if JustTheRecipe::Cookbook.find_by_name(input)
            puts "Here's what's in the cookbook called #{input}:" 
            puts JustTheRecipe::Cookbook.find_by_name(input).return_cookbook
            main_menu
        elsif input == "Create a new cookbook"
            create_cookbook
            main_menu
        elsif input == "Delete a cookbook."
            cookbooks_delete = JustTheRecipe::Cookbook.list_cookbooks << "Exit"
            delete = prompt.select("Which cookbook would you like to delete? WARNING: THIS CANNOT BE UNDONE!", cookbooks_create)  
            JustTheRecipe::Cookbook.delete(delete)
            puts "Ok, we deleted that cookbook."
            main_menu
        elsif input == "Main Menu"
            main_menu
        end
    end

    def new_recipe
        puts "Ok, what would you like to call your new recipe?"
        name = gets.chomp

        puts "Add a short description of your recipe."
        description = gets.chomp

        puts "Add the recipe's ingredients, seperated by a comma. (Ex: 1/2 cup of flour, 2 tbsp sugar, 1 cup water)"
        ingredients = gets.chomp.split(", ")

        puts "Add the recipe's instructions, seperated by a comma. (Ex: Mix the ingredients, cook the recipe, enjoy!)"
        steps = gets.chomp.split(", ")

        puts "\nGreat! Here's your new recipe:"
        manual_recipe = JustTheRecipe::Recipe.new(name, description, ingredients, steps)
        manual_recipe.display_recipe
        add_recipe(manual_recipe)
    end

    def create_cookbook
        puts "Ok! What would you like to name your new cookbook?"
        cookbook = gets.chomp
        JustTheRecipe::Cookbook.new(cookbook)
        puts "Great! We created a new cookbook for you."
        cookbook
    end

    def add_recipe(recipe)
        prompt = TTY::Prompt.new
        puts "Would you like to add this recipe to a cookbook? It won't be saved otherwise. (y/n)"
        input = gets.chomp
        if input == "y"

            cookbooks_create = JustTheRecipe::Cookbook.list_cookbooks << "Create a new cookbook."
            cookbook = prompt.select("Ok! Choose a cookbook to add your recipe to, or create a new one.", cookbooks_create)  
            if cookbook == "Create a new cookbook."
                recipe.add_to_cookbook(create_cookbook)
                puts "We added this recipe to your new cookbook."
                main_menu
            else
                recipe.add_to_cookbook(cookbook)
                puts "We added this recipe to the cookbook called #{cookbook}"
                main_menu
            end
        elsif input == "n"
            puts "No problem. This recipe wasn't added to a cookbook."
            main_menu
        else 
            puts "Sorry, you'll have to answer with either 'y' or 'n'."
            main_menu
        end
    end

    def goodbye
        puts "\n\nThanks for stopping by! If you created any cookbooks, they'll be saved as text files so that you can continue using them in the future. See you soon!"
    end

    

end