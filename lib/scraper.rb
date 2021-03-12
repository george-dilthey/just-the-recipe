require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'pry'

require_relative './recipe.rb'

class Scraper

    attr_accessor :url

    def initialize(url)
        @url=url
    end

    def get_recipe_by_schema
        schema = get_schema

        title = schema["name"]
        description = schema["description"]
        ingredients = schema["recipeIngredient"]
        steps = schema["recipeInstructions"].map {|instruction| instruction["text"].gsub("\n","")}
           
        create_new_recipe(title,description,ingredients,steps)
 
    end

    def get_schema   
        noko = Nokogiri::HTML(open(self.url))
        schemas = JSON.parse(noko.css('script[type*="application/ld+json"]').text)
        recipe_schema = schemas.find{|i| i["@type"] == "Recipe"}
    end

    def create_new_recipe(title, description, ingredients, steps)
        Recipe.new(title,description,ingredients,steps)
    end

end

recipe = Scraper.new('https://www.foodnetwork.com/recipes/ina-garten/blueberry-coffee-cake-muffins-recipe-1917173').get_recipe_by_schema

recipe.print_recipe


