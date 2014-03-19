config_file = Rails.root + "config/config.yaml"
CONFIG = YAML.load(File.read(config_file.to_s))