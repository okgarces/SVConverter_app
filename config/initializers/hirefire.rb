HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    @ironmq = IronMQ::Client.new(:token => "_UbrPaxqhKegRTHcB83w186P1Z8", :project_id => "5281b9309d749a0009000044")
	# Get a queue (if it doesn't exist, it will be created when you first post a message)
	@queue = @ironmq.queue("svconverter_queue")
	# Post a message
	@queue.size
  end
end