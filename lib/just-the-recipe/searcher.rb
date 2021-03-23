class JustTheRecipe::Searcher

    def initialize(search_term)
        @search_term = search_term
    end

    def api_get
        begin    
            base = 'https://api.edamam.com/search'
            q = @search_term
            app_id = ENV["APP_ID"]
            app_key = ENV["APP_KEY"]

            url = "#{base}?q=#{q}&app_id=#{app_id}&app_key=#{app_key}"
            uri = URI.parse(url)

            response = Net::HTTP.get_response(uri)
            results = JSON.parse(response.body)
            hits = results["hits"]
        
            good_url = ""
            hits.each do |hit|
                url = hit["recipe"]["url"]
                if JustTheRecipe::Scraper.new(url).valid_url?
                    good_url = url
                    break
                end

            end
            scrape_recipe(good_url)
        rescue
            puts "Sorry we couldn't find a valid recipe with that search term."
        end
        
    end

    def scrape_recipe(url)
        JustTheRecipe::Scraper.new(url).get_recipe_by_schema
    end

end


# JustTheRecipe::Searcher.new('pie').api_get