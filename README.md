# Just The Recipe

This app allows you to search for recipes on the web, and add them to different cookbooks that you create. The cookbooks are saved as text files so that you can return to them when you're not using the app. 

The app uses a combination of the Edamam API (to search for recipes) and a URL scraper that allows you to input recipe URLs so that you can strip out "Just the Recipe".

Your cookbooks are re-instantiated when you enter the app again so you can continue adding to them over time.

# Installation

Because we save your cookbooks as text files, its best to have this app live in its own repository. Clone down this git repository and then execute:

    $ bundle install

# Usage

## API Access

To use this gem, you'll need to obtain a free APP ID and APP Key from https://www.edamam.com. Once you have these, create a `.env` file and add these lines at the top:

    APP_ID = {YOUR APP ID}
    APP_KEY = {YOUR APP KEY}

Alternatively, you can call `JustTheRecipe.authorize({YOUR APP ID}, {YOUR APP KEY})` before making any other calls, but this will need to be done every time you re-enter the app.

## Running the app

Run the app by running the bin file `just-the-recipe`.
    
    $ bin/just-the-recipe

If you get a permission denied error, run this to give the bin file run permissions:

    $ chmod +x bin/just-the-recipe

Alternatively, you can call the `JustTheRecipe::CLI.new.call` method.

# Supported Websites

Both the search function and the scrape function rely on scraping a website's [recipe schema](https://schema.org/Recipe). Any website that has properly implemented this schema should be scrapable, but these sites have been tested specifically.


* https://www.allrecipes.com
* https://food52.com
* https://www.seriouseats.com
* https://www.marthastewart.com
* https://www.chowhound.com
* https://getmecooking.com
* https://blog.bigoven.com
* https://www.vegrecipesofindia.com


# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/george-dilthey/just-the-recipe.
