require 'active_record'

def db_configuration
  db_configuration_file = File.join('db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

def connect(environment: "development")
  ActiveRecord::Base.establish_connection(db_configuration[environment])
end

connect

puts "Connected to Database"
