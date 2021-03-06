include ActionView::Helpers::TextHelper

class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = t('signin.resetSuccessmsg')
    redirect_to(root_path)
  end

  def edit
    if User.find_by_password_reset_token(params[:id])
      @user = User.find_by_password_reset_token!(params[:id])
    else
      flash[:error] = t('signin.invalidToken')
      redirect_to(root_path)
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t('signin.expiredToken')
    elsif @user.update_attributes(params[:user])
      flash[:success] = t('signin.resetPerformedmsg')
      redirect_to(root_path)
    else
      render :edit
    end
  end

end
