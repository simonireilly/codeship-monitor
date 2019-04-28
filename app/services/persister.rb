require 'active_record'

def db_configuration
  db_configuration_file = File.join('db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

def connect(env: "development")
  ActiveRecord::Base.establish_connection(db_configuration["development"])
end

connect

puts "Connected to Database"
