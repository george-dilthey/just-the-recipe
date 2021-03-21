require 'pry'
class JustTheRecipe::Recipe

    attr_accessor :title, :description, :ingredients, :steps, :url

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

    def display_recipe
        puts " "
        puts "Recipe: #{self.title}"
        puts "Description: #{self.description}"
        self.display_ingredients
        self.display_steps
        puts "Source URL: #{self.url}" 
        puts "***********************"
        puts " "
      
    end
    
    def display_ingredients
        puts "Ingredients:"
        @ingredients.each{|i| puts " • #{i}"}
    end

    def display_steps
        puts "Steps:"
        step_count = 1
        @steps.each do |i|
            puts "  #{step_count}. #{i}"
            step_count += 1
        end
    end

    def add_to_cookbook
        @@all << self
    end

    def self.display_cookbook
        if @@all.length > 0
            puts "Your cookbook:"
            @@all.each {|r| 
                r.display_recipe
            }
        else 
            puts "You don't have anything in your cookbook!"
        end
    end

end

# new_recipe = Recipe.new('cookies', 'delicious cookies', ['chocolate chips', 'flour'],['make cookie batter', 'cook cookies'])
# binding.pry



