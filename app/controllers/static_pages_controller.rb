class StaticPagesController < ApplicationController
  def home
  	#@videos = Video.where(:estado => Video.converted).paginate(page: params[:page], per_page: 30 ,order: ('fecha_publicado DESC'))
  	@videos = Video.where(:estado => Video.converted).sort_by{|e| e[:attach_updated_at]}.reverse
  end

  def help
  end
end
