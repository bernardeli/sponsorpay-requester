require 'yaml'

config = YAML.load_file("./config.yml")[ENV['RACK_ENV']]
AppConfig = OpenStruct.new(config)
