class Usuario < AWS::Record::HashModel
	
  include Dynamoid::Document
  include ActiveModel::SecurePassword

  table :name => :Usuarios, :key => :id, :read_capacity => 5, :write_capacity => 5

  field :id
  field :nombre
  field :apellido
  field :email
  field :password_digest
  field :created_at
  field :updated_at
  field :remember_token

  index :remember_token

  before_save {self.email = email.downcase}
  #before_create {validarpassword}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nombre, presence: true
	validates :apellido, presence: true
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
	has_secure_password 
#Tocó eliminar esta parte ya que no actualizaban los campos en DynamoDB, el problema puede ser por la gema DynamoID
  validates_length_of :password, :minimum => 8, :allow_blank => true
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

    def Usuario.password_digest(password)
      Digest::SHA1.hexdigest(password)
    end

    private 

      def create_remember_token
        self.remember_token = Usuario.encrypt(Usuario.new_remember_token)
      end
end
