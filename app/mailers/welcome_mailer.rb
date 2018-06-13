class WelcomeMailer < ActionMailer::Base
  default from: "discuss.on.it.adm@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome, dear!')
  end
end
