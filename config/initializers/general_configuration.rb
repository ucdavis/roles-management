DSS_RM_CONFIG_FILE = "#{Rails.root.to_s}/config/general.yml"

if File.file?(DSS_RM_CONFIG_FILE)
  $DSS_RM_CONFIG = YAML.load_file(DSS_RM_CONFIG_FILE)
else
  puts "You need to set up #{DSS_RM_CONFIG_FILE} before running this application."
  puts "See config/general.example.yml for an example."
  exit
end
