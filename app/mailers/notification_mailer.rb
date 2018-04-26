class NotificationMailer < ApplicationMailer
	default from: 'diusolexander@gmail.com'
 
  def answer_email
    @user = params[:user]
    @url  = 'http://localhost:3000/'
    @notification = params[:text]
    mail(to: @user.email, subject: 'У вас нова відповідь', 
         template_path: 'notifications',
         template_name: 'answer')
  end
end
