# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'

def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
		File.read(token_file).chomp
	else
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end
end

SVConverterApp::Application.config.secret_key_base = 'b96e1e9308731169f42ddffc15f0169d5d6a5ac29ccdb0e0b5b2fccd5cd50ef2b1ab1757c089a4bd7b5e2fb80f1c7a34f1e75092b8d55f6cf7b2fa39a3a718b6'