# Be sure to restart your server when you modify this file.

#SVConverterApp::Application.config.session_store :cookie_store, key: '_SVConverter_app_session'

require 'action_dispatch/middleware/session/dalli_store'
Rails.application.config.session_store :dalli_store, :memcache_server => ['mc4.dev.ec2.memcachier.com:11211'], :username => '00e098', :password => 'c618f81362' , :namespace => 'sessions', :key => '_foundation_session', :expire_after => 20.minutes, :failover => true, :socket_timeout => 1.5, :socket_failure_delay => 0.2