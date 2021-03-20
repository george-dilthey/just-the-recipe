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
        noko = Nokogiri::HTML(open(@url))
        js = (noko.css('script[type*="application/ld+json"]'))
        js.length == 1 ? schemas = JSON.parse(js.text) : schemas = js.map {|i| valid_json?(i.text) ? JSON.parse(i.text) : nil }   
        recipe_schema = schemas.find{|i| i["@type"] == "Recipe"}
        
    end

    def create_new_recipe(title, description, ingredients, steps)
        JustTheRecipe::Recipe.new(title,description,ingredients,steps)
    end

    def valid_json?(json)
        JSON.parse(json)
        return true
      rescue JSON::ParserError => e
        return false
    end

end

# all_recipe = JustTheRecipe::Scraper.new('http://www.seriouseats.com/recipes/2011/03/bread-baking-70-percent-hydration-bread-recipe.html').get_recipe_by_schema.display_recipe
# # serious = JustTheRecipe::Scraper.new('https://www.seriouseats.com/recipes/2021/03/orecchiette-con-le-cime-di-rapa.html').get_recipe_by_schema

# all_recipe.display_recipe


