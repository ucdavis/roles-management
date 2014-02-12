# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

SECRET_TOKEN_FILE = Rails.root.join( "config", "secret_token.yml")

if File.file?(SECRET_TOKEN_FILE)
  SECRET_TOKEN_SETTINGS = YAML.load_file(SECRET_TOKEN_FILE)
  DSSRM::Application.config.secret_token = SECRET_TOKEN_SETTINGS["SECRET_TOKEN"]
else
  puts "You need to set up config/secret_token.yml before running this application."
  exit
end
