require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'pry'

require_relative './recipe.rb'

class Scraper

    def initialize
    end

    def get_recipe_by_schema(url)
        schema = get_schema(url)
        schema.each do |i| 
            type = i["@type"]
            if type == "Recipe"
                title = i["name"]
                description = i["description"]
                ingredients = i["recipeIngredient"]
                steps = i["recipeInstructions"].map {|ri| ri["text"]}
                create_new_recipe(title,description,ingredients,steps)
            end
        end  
    end

    def get_schema(url)   
        noko = Nokogiri::HTML(open(url))
        schema = JSON.parse(noko.css('script[type*="application/ld+json"]').text)
    end

    def create_new_recipe(title, description, ingredients, steps)
        Recipe.new(title,description,ingredients,steps)
    end

end

Scraper.new.get_recipe_by_schema('https://www.allrecipes.com/recipe/10813/best-chocolate-chip-cookies/')


