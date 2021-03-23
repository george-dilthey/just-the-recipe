require 'dotenv/load'
require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'net/http'
require 'tty-prompt'

Dotenv.require_keys("APP_ID", "APP_KEY")


require './lib/just-the-recipe/version.rb'
require './lib/just-the-recipe/cli.rb'
require './lib/just-the-recipe/cookbook.rb'
require './lib/just-the-recipe/recipe.rb'
require './lib/just-the-recipe/scraper.rb'
require './lib/just-the-recipe/searcher.rb'


