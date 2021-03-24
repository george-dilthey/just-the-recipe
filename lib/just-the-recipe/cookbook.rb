class JustTheRecipe::Cookbook

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        File.write("#{name}.txt", "" , mode: "a")
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create_from_files
        files = Dir["*.txt"]
        files.each do |f|
            name = f.gsub(".txt","")
            find_or_create_by_name(name)
        end    
    end

    def self.find_by_name(name)
        @@all.find{|i| i.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) ? find_by_name(name) : self.new(name)
    end

    def get_recipes
        JustTheRecipe::Recipe.all.select {|i| i.cookbook == self} 
    end

    def write_recipe_to_cookbook(recipe)
        File.write("#{self.name}.txt", recipe.return_recipe , mode: "a")
    end

    def self.list_cookbooks
        @@all.map{|i| i.name}
    end 
    
    def return_cookbook
        File.read("#{@name}.txt")
    end

    def delete_cookbook
        @@all.delete(self)
        File.delete("#{@name}.txt")
    end
end
