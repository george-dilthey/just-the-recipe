# frozen_string_literal: true

require "./lib/environment.rb"

Gem::Specification.new do |spec|
  spec.name          = "just-the-recipe"
  spec.version       = JustTheRecipe::VERSION
  spec.authors       = ["George Dilthey"]
  spec.email         = ["george.dilthey@gmail.com"]

  spec.summary       = "A recipe and cookbook CLI application."
  spec.description   = "A small CLI application to search for recipes and create simple cookbooks."
  spec.homepage      = "https://github.com/george-dilthey/just-the-recipe"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = "https://github.com/george-dilthey/just-the-recipe"
  spec.metadata["source_code_uri"] = "https://github.com/george-dilthey/just-the-recipe"
  spec.metadata["changelog_uri"] = "https://github.com/george-dilthey/just-the-recipe"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "open-uri"
  spec.add_dependency "dotenv"
  spec.add_dependency "nokogiri"
  spec.add_dependency "tty-prompt"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
