class AdminMailer < ApplicationMailer
	def welcome_email(admin, total)
    @admin = admin
    @total = total
    mail(to: @admin.email, subject: 'Welcome to My Awesome Site')
  end
end
