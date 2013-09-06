class UsuariosController < ApplicationController
  
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.paginate(page: params[:page], per_page: 2, order: 'nombre ASC')
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find(params[:id])
    @videos = @usuario.videos.paginate(page: params[:page], per_page: 30, order: 'attach_updated_at DESC')
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)

    respond_to do |format|
      if @usuario.save
        sign_in @usuario
        flash[:success] = 'Usuario fue creado satisfactoriamente'
        format.html { redirect_to @usuario}
        format.json { render action: 'show', status: :created, location: @usuario }
      else
        format.html { render action: 'new' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(param[:id])
    respond_to do |format|
      if @usuario.update(usuario_params)
        flash[:success] = "Perfil correctamente actualizado"
        sig_in @usuario
        format.html { redirect_to @usuario}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end

  private 

  def usuario_params
    params.require(:usuario).permit(:nombre,:apellido, :email, :password, :password_confirmation)
  end

  def correct_user
    @usuario = Usuario.find(params[:id])
    redirect_to(root_url) unless current_user?(@usuario)
  end

end