require 'pry'
require './lib/environment.rb'

class JustTheRecipe::Cookbook

    attr_accessor :name

    def initialize(name)
        @name = name
        File.write("#{name}.txt", "" , mode: "a")
    end

end

gd_cookbook = JustTheRecipe::Cookbook.new("George's Cookbook")
