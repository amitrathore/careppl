# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_careppl_session',
  :secret      => 'f3be99a1fba130c0b4793f43aea5c2077d6b29a4c3352fd40059a865352ef76b93642f3c0202a23f31a3a7d8ddd3b991de65b08b231f33b085451ce316f0a201'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
