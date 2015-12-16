ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'shoulda-matchers'
require 'rspec/json_matcher'
require 'faker'
require 'capybara/email/rspec'
require 'simplecov'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

include ActionDispatch::TestProcess

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

ActiveRecord::Migration.maintain_test_schema!
SimpleCov.start 'rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::JsonMatcher
  config.include ActiveJob::TestHelper
  config.include(RequestSpecHelper, type: :request)

  config.before :suite do
    I18n.locale = :ja
    Faker::Config.locale = :en
    begin
      FactoryGirl.lint
    ensure
      DatabaseRewinder.clean_all
    end
  end

  Autodoc.configuration.template =
    File.read(File.expand_path('../autodoc/templates/document.md.erb',
                               __FILE__))
  Autodoc.configuration.suppressed_request_header =
    %w(Accept Content-Length Host)
  Autodoc.configuration.suppressed_response_header =
    %w(
      Cache-Control Content-Length ETag
      X-Content-Type-Options X-Frame-Options X-Request-Id
      X-Runtime X-XSS-Protection
    )
end
