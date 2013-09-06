class Video < ActiveRecord::Base
	belongs_to :Usuario
	default_scope -> { order('fecha_upload DESC')}
	validates :usuario_id, presence: true
	validates :mensaje, presence: true


	def self.process_video
    if 
    	movie = FFMPEG::Movie.new("public/movie.wmv")
      	movie.transcode("public/success.mp4") { |progress| puts progress }
    end
  end
end
