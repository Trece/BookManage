ActionMailer::Base.delivery_method = :smtp
 
ActionMailer::Base.smtp_settings = {
	:enable_starttls_auto => true,
	:address => 'smtp.gmail.com',
	:port => "587",
	:domain => 'mail.gmail.com',
	:user_name => 'winmad.wlf@gmail.com',
	:password => 'exmuihoxdoyxgyoh',
	:authentication => 'plain'
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

