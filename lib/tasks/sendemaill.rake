task :sendemail => :environment do

enviar 'prueba', 'oscarkiyoshige@hotmail.com', 'Esto es una prueba'

end

def enviaremail(subject, email, body)

am = ActionMailer::Base.new
am.mail(
    :to        => email,
	:from    => 'dkodness@gmail.com',
	:subject   => subject,
    :text_body => body
 	)
end
