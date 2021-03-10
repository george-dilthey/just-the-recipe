
class Recipe

    attr_accessor :title, :description, :ingredients, :steps

    def initialize(title, description, ingredients, steps)
        @title = title
        @description = description
        @ingredients = ingredients
        @steps = steps
    end

end

