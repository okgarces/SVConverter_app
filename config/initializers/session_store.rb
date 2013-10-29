# Be sure to restart your server when you modify this file.

#SVConverterApp::Application.config.session_store :cookie_store, key: '_SVConverter_app_session'

require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store, :memcache_server => ['sessionconverter.n9rvzs.cfg.use1.cache.amazonaws.com:11211'], :namespace => 'sessions', :key => '_foundation_session', :expire_after => 20.minutes