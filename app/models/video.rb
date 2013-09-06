class Video < ActiveRecord::Base
	belongs_to :Usuario
	default_scope -> { order('fecha_upload DESC')}
	validates :usuario_id, presence: true
	validates :mensaje, presence: true



	def process_video
		system("ffmpeg -i public/movie.flv -strict experimental public/movie.mp4")
	end
	
end
