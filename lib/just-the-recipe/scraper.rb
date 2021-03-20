require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'pry'

require './lib/environment.rb'

class JustTheRecipe::Scraper

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
        JustTheRecipe::Recipe.new(title,description,ingredients,steps)
    end

end

# recipe = JustTheRecipe::Scraper.new('https://www.allrecipes.com/recipe/270712/air-fryer-coconut-shrimp/').get_recipe_by_schema

# recipe.display_recipe


