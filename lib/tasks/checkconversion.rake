task :checkconversion => :environment do

STATE_PROCESSING = 0
STATE_CONVERTED = 1

while 0==0 do

	sleep 10
	
	@ironmq = IronMQ::Client.new(:token => "_UbrPaxqhKegRTHcB83w186P1Z8", :project_id => "5281b9309d749a0009000044")
	# Get a queue (if it doesn't exist, it will be created when you first post a message)
	@queue = @ironmq.queue("svconverter_queue")
	# Post a message
	@msg = @queue.get()
	
	if !@msg.nil?

	@parts = @msg.body.split(';')
	puts @parts

		if @parts[0].to_i == STATE_PROCESSING
			video = Video.find(@parts[1])
			video_url = video.attach.url
			puts video.attach.url.to_s + video.attach.original_filename
			video_filename = video.attach.original_filename
		    video_converted_url = "#{Rails.root}/tmp/converted_#{rand(10241024)}_"+video_filename[0,video_filename.size-4]+'.mp4'
		    puts exec "#{Rails.root}/bin/ffmpeg -y -i "+ video_url + " -vcodec libx264 " +video_converted_url
		    converted = File.open(video_converted_url)
			puts converted
			video.attach = converted
			converted.close
			File.delete(video_converted_url)
			video.estado = STATE_CONVERTED
			video.fecha_publicado = Time.zone.now
			video.save
			@msg.delete
		end
	end
end
end