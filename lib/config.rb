require 'yaml'

config = YAML.load_file("./config.yml")['default']
AppConfig = OpenStruct.new(config)
