# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_reanimation_library_session',
  :secret      => 'b41f0878d4039456c3a658fdddf3cbd57a6f564719c7ebb286879892701441329c6f72ec34753b05d7ef5dc1fd18132a1ca574b478ea4339eabd855b84626929'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
