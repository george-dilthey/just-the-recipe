
class Authenticate
    
    def initialize(app_id, app_key)
        @app_id, @app_key = app_id, app_key
        File.write(".env", "APP_ID = #{app_id.to_s}\nAPP_KEY = #{app_key.to_s}")
    end

end

Authenticate.new('6d8b7767', 'e1633ded1da9906633b79ec6c8525ac5')