task :checkconversion => :environment do

STATE_PROCESSING = 0
STATE_CONVERTED = 1

while 0==0 do

	sleep 10
	@sqs = AWS::SQS.new
	@queue = @sqs.queues.create("dev_svconverterqueue")
	@msg = @queue.receive_message
	puts "mensaje recibido"+@msg.to_s

	if !@msg.nil?

	@parts = @msg.body.split(';')
	puts @parts

		if @parts[0].to_i == STATE_PROCESSING
			video = Video.find(@parts[1])
			video_url = video.attach.url
			puts video.attach.url.to_s + video.attach.original_filename
			video_filename = video.attach.original_filename
			puts system("ffmpeg -i "+ video_url+ " -vcodec libx264 -strict experimental #{Rails.root}/public/system/temp/"+ video_filename[0,video_filename.size-4]+".mp4")
			converted = File.open("#{Rails.root}/public/system/temp/"+video_filename[0,video_filename.size-4]+".mp4")
			video.attach = converted
			converted.close
			File.delete("#{Rails.root}/public/system/temp/"+video_filename[0,video_filename.size-4]+".mp4")
			video.estado = STATE_CONVERTED
			video.fecha_publicado = Time.zone.now
			video.save!
			@msg.delete
			enviaremail 'Video publicado', Usuario.find(video.usuario_id).email, 'El video: '+video.attach.original_filename+' ha sido publicado exitosamente'

		end
	end
end
end

def enviaremail(subject, email, body)

ses = AWS::SES::Base.new(
  :access_key_id     => ENV['AMAZON_IAM_ID'], 
  :secret_access_key => ENV['AMAZON_IAM_SECRET']
)
ses.send_email(
    :to        => email,
	:from    => 'dkodness@gmail.com',
	:subject   => subject,
    :text_body => body
 )
end