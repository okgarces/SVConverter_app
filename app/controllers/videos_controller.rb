class VideosController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.paginate(page: params[:page], per_page: 2, order: 'nombre ASC')
 
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    # Esta solución no es viable con la versión de Dynamoid 0.7.1
    @video = current_user.videos.create(video_params)
    @video.usuario_id = current_user.id
    respond_to do |format|
      if @video.save
        flash[:success] = "El video ha sido posteado, pasarán unos segundos para ser publicado"
        format.html { redirect_to current_user }
        format.json { render action: 'show', status: :created, location: @video }
      else
        puts @video.to_s
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  def convertirPrueba
    videoConverter = Video.new
    #Falta crear una instancia válida de un video para poder hacer el delayed job
    videoConverter.delay.process_video    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:nombre, :mensaje, :attach, :attach_file_name)
    end
end
