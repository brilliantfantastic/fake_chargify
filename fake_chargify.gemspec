
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'fake_chargify'
  s.version           = '0.1.0'
  s.date              = '2011-11-29'
  s.rubyforge_project = 'fake_chargify'

  s.summary     = "A helper for faking web requests and responses to and from the Chargify API."
  s.description = "A helper for faking web requests and responses to and from the Chargify API."

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Jamie Wright"]
  s.email    = 'jamie@brilliantfantastic.com'
  s.homepage = 'http://github.com/brilliantfantastic/fake_chargify'

  s.require_paths = %w[lib]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  s.add_dependency('webmock', "~> 1.7.8")
  s.add_dependency('nokogiri', "~> 1.5.0")

  #s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    Rakefile
    fake_chargify.gemspec
    lib/fake_chargify.rb
    lib/fake_chargify/configuration.rb
    lib/fake_chargify/credit_card.rb
    lib/fake_chargify/customer.rb
    lib/fake_chargify/customer_registry.rb
    lib/fake_chargify/product.rb
    lib/fake_chargify/product_family.rb
    lib/fake_chargify/statement.rb
    lib/fake_chargify/statement_registry.rb
    lib/fake_chargify/string_patches.rb
    lib/fake_chargify/subscription.rb
    lib/fake_chargify/subscription_registry.rb
    lib/fake_chargify/url_parser.rb
    readme.md
    spec/fake_chargify/configuration_spec.rb
    spec/fake_chargify/credit_card_spec.rb
    spec/fake_chargify/customer_spec.rb
    spec/fake_chargify/product_family_spec.rb
    spec/fake_chargify/product_spec.rb
    spec/fake_chargify/statement_spec.rb
    spec/fake_chargify/subscription_spec.rb
    spec/fake_chargify_spec.rb
    spec/spec_helper.rb
    spec/string_patches_spec.rb
  ]
  # = MANIFEST =
end