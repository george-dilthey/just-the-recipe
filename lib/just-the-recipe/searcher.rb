require 'pry'

require './lib/environment.rb'

class JustTheRecipe::Searcher

    def initialize(search_term)
        @search_term = search_term
    end

    def api_get
        base = 'https://api.edamam.com/search'
        q = @search_term
        app_id = ENV["APP_ID"]
        app_key = ENV["APP_KEY"]

        url = "#{base}?q=#{q}&app_id=#{app_id}&app_key=#{app_key}"
        uri = URI.parse(url)

        response = Net::HTTP.get_response(uri)
        results = JSON.parse(response.body)
        all_recipes = results["hits"]
        first_result = all_recipes.find {|f| f["recipe"]["source"] == "Serious Eats"}
        #  = results["hits"][0]["recipe"]
        # name = first_result["label"]
        # description = 
        # ingredients = first_result["ingredientLines"]
        # binding.pry

    end


end


JustTheRecipe::Searcher.new('bread').api_get