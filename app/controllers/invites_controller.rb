class InvitesController < ApplicationController
  def create
    @invite = Invite.new(name: params[:invite][:name], email: params[:invite][:email], bio: params[:invite][:bio], reason: params[:invite][:reason], rtype: params[:commit])
    if @invite.save
      if params[:commit] == "Submit"
        flash[:success] = "Inviation request sent"
      else
        flash[:success] = "We'll let you know when Hyve.me is going into public beta."
      end
    else
      flash[:error] = "There was an error with your input: " + @invite.errors.full_messages.join
    end
    redirect_to root_path
  end
end
