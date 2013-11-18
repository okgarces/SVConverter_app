# Load the Rails application.
require File.expand_path('../application', __FILE__)

Paperclip::Attachment.default_options.update({
    :storage          => :fog,
    :fog_credentials  => {
      :provider           => 'Rackspace',
      :rackspace_username => 'okgarces',
      :rackspace_api_key  => 'b3468152f631ab0d9427c25efdb76915',
      :persistent         => false
    },
    :fog_directory    => 'svconverter',
    :fog_public       => true
})

# Initialize the Rails application.
SVConverterApp::Application.initialize!