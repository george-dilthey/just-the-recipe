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
        hits = results["hits"]
        hits.each do |hit|
            url = hit["recipe"]["url"]
            if scrape_recipe(url).class == JustTheRecipe::Recipe
                return url
                break
            end
        end
    end

    def scrape_recipe(url)
        JustTheRecipe::Scraper.new(url).get_recipe_by_schema
    end

end


JustTheRecipe::Searcher.new('bread').api_get