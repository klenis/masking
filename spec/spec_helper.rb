require "bundler/setup"
require 'tapp'
require 'simplecov'
require 'coveralls'
if ENV['CI'] == 'true'
  Coveralls.wear!
else
  SimpleCov.start { add_filter %r{^/spec/} }
end

require "masking"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def config_fixture_path(name = 'target_columns.yml')
  Pathname('spec/fixtures/config').join(name)
end

def insert_statement_fixture(name = 'sample.sql')
  Pathname('spec/fixtures/insert_statement').join(name).read.chomp
end

def sql_dump_line_fixture(name)
  Pathname('spec/fixtures/sql_dump_line').join(name).read.chomp
end
