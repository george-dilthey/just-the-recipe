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
        if schema["recipeInstructions"][0]["itemListElement"]
            steps = schema["recipeInstructions"].map {|section| section["itemListElement"].map {|instruction| instruction["text"].gsub("\n","")}}.flatten
        else
            steps = schema["recipeInstructions"].map {|instruction| instruction["text"].gsub("\n","")}
        end
        create_new_recipe(title,description,ingredients,steps, @url)
    end

    def get_schema   
        noko = Nokogiri::HTML(open(@url))
        js = (noko.css('script[type*="application/ld+json"]'))
        if js.length == 1 
            parsed = JSON.parse(js.text)
            if parsed.class == Hash
                graph = parsed["@graph"]
                recipe = graph.find{|i| i["@type"] == "Recipe"}
            else
                recipe = parsed.find{|i| i["@type"] == "Recipe"}
            end
        else
            parsed = js.map {|i| valid_json?(i.text) ? JSON.parse(i.text) : nil }
            recipe = parsed.find{|i| i["@type"] == "Recipe"}
        end
    end

    def create_new_recipe(title, description, ingredients, steps, url)
        JustTheRecipe::Recipe.new(title,description,ingredients,steps,url)
    end

    def valid_json?(json)
        JSON.parse(json)
        return true
      rescue JSON::ParserError => e
        return false
    end

    def valid_url?
        begin
            get_schema
        rescue
            false          
        end
    
    end

end

# veg = JustTheRecipe::Scraper.new('https://www.vegrecipesofindia.com/eggless-chocolate-chip-muffins-recipe/').get_recipe_by_schema.display_recipe
# all_recipe = JustTheRecipe::Scraper.new('https://www.allrecipes.com/recipe/10813/best-chocolate-chip-cookies/').get_recipe_by_schema.display_recipe
# serious = JustTheRecipe::Scraper.new('https://www.seriouseats.com/recipes/2021/03/orecchiette-con-le-cime-di-rapa.html').get_recipe_by_schema.display_recipe

# all_recipe.display_recipe


