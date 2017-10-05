require 'bundler/setup'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
)

require_all 'app'
