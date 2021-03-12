
class Recipe

    attr_accessor :title, :description, :ingredients, :steps

    def initialize(title, description, ingredients, steps) # ingredients and steps are arrays
        @title = title
        @description = description
        @ingredients = ingredients
        @steps = steps
    end

    def print_recipe
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


end

