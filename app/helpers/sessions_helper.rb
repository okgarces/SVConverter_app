module SessionsHelper
	def sign_in(user)
		remember_token = Usuario.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.remember_token=Usuario.encrypt(remember_token)
		user.save!

		Rails.logger.info("Token actual" + remember_token)
		#user.update_attribute!(:remember_token, Usuario.encrypt(remember_token))
		self.current_user= user
		Rails.logger.info("Token del usuario: " + self.current_user.remember_token)
	end


	def current_user=(user)
		@current_user = user
		
	end
	def current_user
		remember_token = Usuario.encrypt(cookies[:remember_token])
		@current_user ||= Usuario.find_by({'remember_token' => remember_token})
	end
	def current_user?(user)
		user==current_user
	end
	def signed_in?
		!current_user.nil?		
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
	end
	def store_location
		session[:return_to] = request.url
	end
	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Por favor Inicie Sesión"
      end
  end
end