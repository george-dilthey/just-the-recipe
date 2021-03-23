class JustTheRecipe::Authenticate
    
    def initialize(app_id, app_key)
        @app_id, @app_key = app_id, app_key
        File.write(".env", "APP_ID = #{app_id.to_s}\nAPP_KEY = #{app_key.to_s}")
    end

end

