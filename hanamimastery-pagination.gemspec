# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative "lib/hanamimastery/pagination/version"

Gem::Specification.new do |spec|
  spec.name = "hanamimastery-pagination"
  spec.version = Hanamimastery::Pagination::VERSION
  spec.authors = ["Sebastian Wilgosz"]
  spec.email = ["sebastian@hanamimastery.com"]

  spec.summary = "A pagination implementation for Ruby applications."
  spec.description = <<~STRING
    A pagination engine powered up with algebraic effects implementation provided by dry-effects.
    It allows to paginate any resource without passing down pagination parameters as arguments.
  STRING
  spec.homepage = "https://github.com/hanamimastery/pagination"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hanamimastery/pagination"
  spec.metadata["changelog_uri"] = "https://github.com/hanamimastery/pagination/tree/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-effects", "~> 0.4"
  spec.add_dependency "dry-struct", "~> 1.6"
  spec.add_dependency "dry-types", "~> 1.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
