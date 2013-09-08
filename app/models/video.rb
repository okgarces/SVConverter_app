class Video < ActiveRecord::Base
	
	# States
	STATE_PROCESSING = 0
	STATE_CONVERTED = 1

	# Once the video is uploaded the state must be SET and
	# the 
	before_create { self.estado = STATE_PROCESSING } 
	after_save { convert_video }


	# Model configurations
	belongs_to :Usuario
	default_scope -> { order('attach_updated_at DESC')}
	
	validates :usuario_id, presence: true
	validates :mensaje, presence: true
	
	# For the use of gem Paperclip
	has_attached_file :attach
	validates_attachment_presence :attach
	#validates_attachment_content_type :attach, :content_type => ['movie/quicktime','movie/avi','movie/mpg']

	def self.converted
		STATE_CONVERTED
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
		self.delay.process_video    

	end
	def process_video
		if self.estado == STATE_PROCESSING
			video_url = self.attach.url(nil, false)
			system("ffmpeg -i #{Rails.root}/public"+ video_url+ " -vcodec libx264 -strict experimental #{Rails.root}/public"+ video_url[0,video_url.size-4]+".mp4")
			converted = File.open("#{Rails.root}/public"+video_url[0,video_url.size-4]+".mp4")
			self.attach = converted
			converted.close
			self.estado = STATE_CONVERTED
			self.fecha_publicado = Time.zone.now
			self.save!
		end
	end

end