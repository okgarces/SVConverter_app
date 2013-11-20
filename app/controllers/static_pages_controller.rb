class StaticPagesController < ApplicationController
  def home
  	#@videos = Video.where(:estado => Video.converted).paginate(page: params[:page], per_page: 30 ,order: ('fecha_publicado DESC'))
  	@videos = Video.where(:estado => Video.converted).sort_by{|e| e[:attach_updated_at]}.reverse
  end

  def loaderio
  	#render 'loaderio-1495b157ce5681d327996eba1013333c.html'
  	send_data "loaderio-1495b157ce5681d327996eba1013333c.txt"
  end
end
