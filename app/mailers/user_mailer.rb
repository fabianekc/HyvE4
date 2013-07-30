class UserMailer < ActionMailer::Base
  default from: ENV['MAILER_FROM']
  default reply_to: ENV['MAILER_REPLY_TO']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def welcome(user)
    @user = user
    mail :to => user.email
  end

  def password_reset(user)
    @user = user
    mail :to => user.email
  end

end
