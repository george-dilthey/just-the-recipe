require 'pry'
require './lib/environment.rb'

class JustTheRecipe::Recipe

    attr_accessor :title, :description, :ingredients, :steps, :url, :cookbook

    @@all = []

    def initialize(title, description, ingredients, steps, url) # ingredients and steps are arrays
        @title = title
        @description = description
        @ingredients = ingredients
        @steps = steps
        @url = url
    end

    def self.all
        @@all
    end

    def return_recipe
        "\nRecipe: #{@title}\nDescription: #{@description}\nIngredients:\n#{self.return_ingredients}Steps:\n#{self.return_steps}Source URL: #{self.url}\n***********************\n"   
    end

    def return_ingredients
        string = ""
        @ingredients.each{|i| string<< "• #{i}\n"}
        string
    end

    def return_steps
        string = ""
        step_count = 1
        @steps.each do |i|
            string << "  #{step_count}. #{i}\n"
            step_count += 1
        end
        string
    end

    def display_recipe
        puts "#{return_recipe}"
    end

    def add_to_cookbook(name)
        self.cookbook = JustTheRecipe::Cookbook.find_or_create_by_name(name)
        self.cookbook.write_recipe_to_cookbook(self) 
    end

    def self.display_cookbook
        if @@all.length > 0
            @@all.each {|r| 
                r.display_recipe
            }
        else 
            puts "You don't have anything in your cookbook!"
        end
    end

    # def save_to_cookbook(cookbook_name)
    #     File.write("#{cookbook_name}.txt", self.return_recipe, mode: "a")
    # end

end

# new_recipe = JustTheRecipe::Recipe.new('cookies', 'delicious cookies', ['chocolate chips', 'flour'],['make cookie batter', 'cook cookies'], "www.google.com")
# new_recipe.add_to_cookbook("George's Cookbook")
# binding.pry



