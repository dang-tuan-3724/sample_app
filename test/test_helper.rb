ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    # Logs in a test user.
    def log_in_as(user, options = {})
      password    = options[:password]    || 'password'
      remember_me = options[:remember_me] || '1'
      post login_path, params: { session: { email: user.email,
                                            password: password,
                                            remember_me: remember_me } }
    end

    private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
  end
end
