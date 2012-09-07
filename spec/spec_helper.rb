require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  require 'rubygems'
  ENV["RAILS_ENV"] ||= 'test'

  # TODO: setup simplecorv
  # unless Spork.using_spork? && ENV["COVERAGE"]
  #   puts "Running Coverage Tool\n"
  #   require 'simplecov'
  #   SimpleCov.start 'rails' do
  #     add_filter "spec/"
  #   end
  # end

  # Reloading models in Rails 3.1 when usign Spork and cache_classes = true
  # see http://migre.me/9Upt5 for understand
  # (begin)
    require 'rails/application'

    # Use of https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujutsu
    Spork.trap_method(Rails::Application, :reload_routes!)
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

    # Prevent main application to eager_load in the prefork block (do not load
    # files in autoload_paths)
    Spork.trap_method(Rails::Application, :eager_load!)

    # Below this line it is too late...
    require File.expand_path("../../config/environment", __FILE__)
    # Load all railties files
    Rails.application.railties.all { |r| r.eager_load! }
  # (end)

  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rails'
  require 'capybara/poltergeist'

  # if Spork.using_spork?
  #   # requires to reduce test load-time as test with script tooked from:
  #   # http://migre.me/9UpBP
  # end

  # Improve the performance of the test suite: http://migre.me/9UpDp
  # (begin)
    # uncomment when using devise
    # Devise.stretches = 1
    Rails.logger.level = 4

    class ActiveRecord::Base
      mattr_accessor :shared_connection
      @@shared_connection = nil

      def self.connection
        @@shared_connection || retrieve_connection
      end
    end
  # (end)

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # check phantomjs availability in order to use poltergeist driver on capybara
    def js_driver
      system("which phantomjs > /dev/null 2>&1") ? :poltergeist : :webkit
    end

    Capybara.javascript_driver = js_driver

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  # Forces all threads to share the same connection. This works on
  # Capybara because it starts the web server in a thread.
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  # This steps will only be runned when using spork
  FactoryGirl.reload if Spork.using_spork?
end