task :sendemail => :environment do

enviar 'prueba', 'oscarkiyoshige@hotmail.com', 'Esto es una prueba'

end

def enviar(subject, email, body)

ses = AWS::SES::Base.new(
  :access_key_id     => ENV['AMAZON_IAM_ID'], 
  :secret_access_key => ENV['AMAZON_IAM_SECRET']
)
ses.send_email(
    :to        => email,
	:from    => 'dkodness@gmail.com',
	:subject   => subject,
    :text_body => body
 )
end
