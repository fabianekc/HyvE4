class StructMailer < ActionMailer::Base
  default from: ENV['MAILER_DATA_FROM']
  default reply_to: ENV['MAILER_REPLY_TO']

  def request_first_list(struct)
    @struct=struct
    @group = Group.find_by_id(@struct.group_id)
    @project = Project.find_by_id(@group.project_id)
    @user=User.find_by_id(@project.user_id)
    mail(:to => @user.email, :subject => "[" + @project.name + "] " + @struct.name)
  end
end
