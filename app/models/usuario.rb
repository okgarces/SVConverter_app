class Usuario < ActiveRecord::Base
	before_save {self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nombre, presence: true
	validates :apellido, presence: true
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
	has_secure_password
		validates :password, length: {minimum: 8}
	has_many :Videos
	
end
