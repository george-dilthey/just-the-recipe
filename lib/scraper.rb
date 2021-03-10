require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'pry'

class Scraper

    def initialize
    end

    def get_recipe_by_schema(url)
        schema = get_schema(url)
        schema.each do |i| 
            type = i["@type"]
            if type == "Recipe"
                puts type
            end
        end
    end

    def get_schema(url)   
        noko = Nokogiri::HTML(open(url))
        schema = JSON.parse(noko.css('script[type*="application/ld+json"]').text)
    end

end

Scraper.new.get_recipe_by_schema('https://www.allrecipes.com/recipe/10813/best-chocolate-chip-cookies/')