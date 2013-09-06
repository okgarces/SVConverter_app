class StaticPagesController < ApplicationController
  def home
  	@videos = Video.where(:estado => Video.converted).paginate(page: params[:page], per_page: 30 ,order: ('fecha_publicado DESC'))
  end

  def help
  end
end
