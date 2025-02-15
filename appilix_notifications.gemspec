# frozen_string_literal: true

#require_relative "lib/appilix_notifications/version"

Gem::Specification.new do |spec|
  spec.name = "appilix_notifications"
  #spec.version = AppilixNotifications::VERSION
  spec.version = "0.1.1"
  spec.authors = ["RoaaAlqaisi"]
  spec.email = ["rowaalqaisi@gmail.com"]
  spec.license = "NGPL"

  spec.summary = "A Ruby gem to send notifications using the appilix API."
  spec.description = "appilixNotifications is a Ruby gem that simplifies sending push notifications to users of your application via the appilix API. It includes functionality to fetch registered users and send notifications with customizable titles, bodies, and optional user-specific or link-specific parameters."
  spec.homepage = "https://github.com/RoaaAlqaisi/appilix_notifications"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RoaaAlqaisi/appilix_notifications"
  spec.metadata["changelog_uri"] = "https://github.com/RoaaAlqaisi/appilix_notifications/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0")

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Add dependencies for your gem
  spec.add_dependency "json", "~> 2.0"
  spec.add_dependency "net-http", ">= 0.1.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
