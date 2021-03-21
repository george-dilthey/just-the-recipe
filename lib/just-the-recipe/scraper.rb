require 'pry'

require './lib/environment.rb'

class JustTheRecipe::Scraper

    attr_accessor :url

    def initialize(url)
        @url=url
    end

    def get_recipe_by_schema
        schema = get_schema

        schema.key?("name") ? title = schema["name"] : nil
        schema.key?("description") ? description = schema["description"] : nil
        schema.key?("recipeIngredient") ? ingredients = schema["recipeIngredient"] : ingredients = []
        if schema.key?("recipeInstructions") 
            if schema["recipeInstructions"][0].class == Hash && schema["recipeInstructions"][0].key?("itemListElement")
                steps = schema["recipeInstructions"].map {|section| section["itemListElement"].map {|instruction| instruction["text"].gsub("\n","")}}.flatten
            elsif schema["recipeInstructions"][0].class == Array
                steps = schema["recipeInstructions"].flatten.map {|instruction| instruction["text"].gsub("\n","")}
            elsif schema["recipeInstructions"].class == Array
                steps = schema["recipeInstructions"].map {|instruction| instruction["text"].gsub("\n","")}
            else
                steps = [schema["recipeInstructions"]]
            end
        else 
            steps = [] 
        end
        create_new_recipe(title,description,ingredients,steps, @url)
    end

    def get_schema   
        noko = Nokogiri::HTML(open(@url))
        if (noko.css('script[type*="application/ld+json"].yoast-schema-graph')).length > 0
            js = (noko.css('script[type*="application/ld+json"].yoast-schema-graph'))
            parsed = JSON.parse(js.text)
            graph = parsed["@graph"]
            recipe = graph.find{|i| i["@type"] == "Recipe"}
        else
            js = (noko.css('script[type*="application/ld+json"]'))
            if js.length == 1 
                parsed = JSON.parse(js.text)
                parsed.class != Array ? parsed = [parsed] : parsed = parsed
                recipe = parsed.find{|i| i["@type"] == "Recipe"}
            else
                parsed = js.map {|i| valid_json?(i.text) ? JSON.parse(i.text) : nil }
                recipe = parsed.find{|i| i["@type"] == "Recipe"}
            end
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
# get = JustTheRecipe::Scraper.new('https://getmecooking.com/recipes/gambas-al-ajillo-con-setas/').get_recipe_by_schema.display_recipe
# big = JustTheRecipe::Scraper.new('https://blog.bigoven.com/category/bigoven-tips/page/15/').get_recipe_by_schema.display_recipe
# martha = JustTheRecipe::Scraper.new('https://www.marthastewart.com/1511143/potato-galettes').get_recipe_by_schema.display_recipe
# food52 = JustTheRecipe::Scraper.new('https://food52.com/recipes/2250-potatoe-chipotle-tacos').get_recipe_by_schema.display_recipe
# chowhound = JustTheRecipe::Scraper.new('https://www.chowhound.com/recipes/tomato-pie-31670').get_recipe_by_schema.display_recipe
# food52part2 = JustTheRecipe::Scraper.new('https://food52.com/recipes/10168-sugar-pie').get_recipe_by_schema.display_recipe
# all_recipe.display_recipe


