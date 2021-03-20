
require 'pry'
class Recipe

    attr_accessor :title, :description, :ingredients, :steps

    @@all = []

    def initialize(title, description, ingredients, steps) # ingredients and steps are arrays
        @title = title
        @description = description
        @ingredients = ingredients
        @steps = steps
    end

    def self.all
        @@all
    end

    def display_recipe
        puts "Here's your recipe:"
        puts " "
        puts "Recipe: #{self.title}"
        puts "Description: #{self.description}"
        display_ingredients(ingredients)
        display_steps(steps)       
    end
    
    def display_ingredients(array)
        puts "Ingredients:"
        array.map{|i| puts " • #{i}"}
    end

    def display_steps(array)
        puts "Steps:"
        step_count = 1
        array.each do |i|
            puts "  #{step_count}. #{i}"
            step_count += 1
        end
    end

    def add_to_cookbook
        @@all << self
    end

    def self.display_cookbook
        puts "Your cookbook:"
        @@all.each {|r| 
            r.display_recipe
            puts "***********************"
            puts ""
        
        }

    end

end

# new_recipe = Recipe.new('cookies', 'delicious cookies', ['chocolate chips', 'flour'],['make cookie batter', 'cook cookies'])
# binding.pry


