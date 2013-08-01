include ActionView::Helpers::TextHelper

class InvitesController < ApplicationController
  def create
    @invite = Invite.new(name: params[:invite][:name], email: params[:invite][:email], bio: params[:invite][:bio], reason: params[:invite][:reason], rtype: params[:commit])
    if @invite.save
      if params[:commit] == t('welcome.submitbtn')
        flash[:success] = t('welcome.invitationFlash')
      else
        flash[:success] = t('welcome.publicBetaFlash')
      end
    else
      flash[:error] = t('general.inputerror') + @invite.errors.full_messages.join
    end
    redirect_to root_path
  end
end
