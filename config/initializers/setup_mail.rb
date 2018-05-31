ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "free.com",
  :user_nickname        => "free",
  :password             => "secret",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
require 'development_mail_interceptor'
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?