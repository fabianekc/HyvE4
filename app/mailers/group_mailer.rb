class GroupMailer < ActionMailer::Base
  default from: ENV['MAILER_DATA_FROM']
  default reply_to: ENV['MAILER_DATA_REPLY_TO']

  def request_first_list(group)
    @group   = group
    @structs = Structure.where(group_id: @group.id)
    @project = Project.find_by_id(@group.project_id)
    @user    = User.find_by_id(@project.user_id)
    mail(:to => @user.email, :subject => "[" + @project.name + "] " + @group.name)
  end
end
