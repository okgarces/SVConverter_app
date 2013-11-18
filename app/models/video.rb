class Video
	include Mongoid::Document
	include Mongoid::Paperclip

  	field :nombre
  	field :usuario_id
    field :mensaje
    field :estado, type: Integer
    field :fecha_publicado
    field :created_at
    field :updated_at
    field :attach_file_name
    field :attach_content_type
    field :attach_file_size
    field :attach_updated_at
    field :nombre

	# States
	STATE_PROCESSING = 0
	STATE_CONVERTED = 1

	# Once the video is uploaded the state must be SET and
	# the 
	before_create { self.estado = STATE_PROCESSING } 
	after_create { convert_video }


	# Model configurations
	belongs_to :Usuario
	#default_scope -> { order('attach_updated_at DESC')}
	
	#validates :usuario_id, presence: true
	validates :mensaje, presence: true
	
	# For the use of gem Paperclip
	has_mongoid_attached_file :attach
	validates_attachment_presence :attach
	#validates_attachment_content_type :attach, :content_type => ['movie/quicktime','movie/avi','movie/mpg']

	def self.converted
		STATE_CONVERTED
	end
	def converted?
		return (self.estado == STATE_CONVERTED)
	end
	def self.estado_to_s(estado)
		if estado == STATE_CONVERTED
			"Publicado"
		elsif estado == STATE_PROCESSING
			"Procesando"
		else
			"ERROR DE ESTADO"
		end
	end

	def convert_video
		#Aquí va el código para colocar en la cola los mensajes en SQS 
		#@sqs = AWS::SQS.new
		#@queue = @sqs.queues.create("dev_svconverterqueue")
		#@queue.send_message(self.estado.to_s+";"+self.id+";")
		# Create an IronMQ::Client object
		@ironmq = IronMQ::Client.new(:token => "_UbrPaxqhKegRTHcB83w186P1Z8", :project_id => "5281b9309d749a0009000044")
		# Get a queue (if it doesn't exist, it will be created when you first post a message)
		@queue = @ironmq.queue("svconverter_queue")
		# Post a message
		@queue.post(self.estado.to_s+";"+self.id+";")
	end
	def process_video
		#Esto lo vamos a crear como un rake
		if self.estado == STATE_PROCESSING
			video_url = self.attach.url(nil, false)
			video_filename = self.attach.original_filename
			system("ffmpeg -i "+ video_url+ " -vcodec libx264 -strict experimental #{Rails.root}/public/system/temp/"+ video_filename[0,video_filename.size-4]+".mp4")
			converted = File.open("#{Rails.root}/public/system/temp/"+video_filename[0,video_filename.size-4]+".mp4")
			self.attach = converted
			converted.close
			File.delete("#{Rails.root}/public/system/temp/"+video_filename[0,video_filename.size-4]+".mp4")
			self.estado = STATE_CONVERTED
			self.fecha_publicado = Time.zone.now
			self.save!
		end
	end

end