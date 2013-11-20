class SendNotification < ActionMailer::Base
  default from: "info@app19299671.mailgun.org"

def enviaremail(subject, email, body)
mail(:to => email, :subject => subject, :body => body)
end
end
