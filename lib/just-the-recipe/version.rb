module JustTheRecipe
    VERSION = "0.11.0"

    @@app_id = ENV["APP_ID"]
    @@app_key = ENV["APP_KEY"]

    def self.authorize(app_id, app_key)
        @@app_id = app_id
        @@app_key = app_key
    end

    def self.app_id
        @@app_id
    end

    def self.app_key
        @@app_key
    end
end