class Usuario < ActiveRecord::Base
	before_save {self.email = email.downcase}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nombre, presence: true
	validates :apellido, presence: true
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
	has_secure_password
		validates :password, length: {minimum: 8}
	has_many :videos, dependent: :destroy
	
	 private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:nombre, :apellido, :email, :password, :password_confirmation)
    end

    def Usuario.new_remember_token
      SecureRandom.urlsafe_base64
    end

    def Usuario.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    private 

      def create_remember_token
        self.remember_token = Usuario.encrypt(Usuario.new_remember_token)
      end
end
