include ActionView::Helpers::TextHelper

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @postings = @user.postings.paginate(page: params[:page])
    @projects = @user.projects
  end

  def new
    if signed_in?
      @user = current_user
      @posting = current_user.postings.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @projects = @user.projects
      @project = current_user.projects.build
    else
      @user = User.new
      @invite = Invite.new
      @users = User.all
      @projects = Project.all
      @postings = Posting.all
      @datavals = Dataval.all
    end
  end

  def create
    if ENV['INVITE_CODE'].split(",").include?(params[:user][:invitecode])
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        @user.send_welcome
        flash[:success] = t('welcome.welcomeflash')
        flash[:info] = t('welcome.welcomehint')
        redirect_to root_path
      else
        flash[:error] = "Please fix the following " + pluralize(@user.errors.count, "error") + ": " + @user.errors.full_messages.join(", ")
        @invite = Invite.new
        @users = User.all
        @projects = Project.all
        @postings = Posting.all
        @datavals = Dataval.all
        render 'new'
      end
    else
      flash[:error] = t('welcome.invalidInvitecodemsg')
      redirect_to root_path
    end
  end

  def create_project
    @user = User.find(params[:id])
    @newproject=@user.projects.build(name: params['project']['name'], description: params['project']['description'])
    if @newproject.save
      flash[:success] = t('project.created')
      flash[:info] = t('project.createdHint')
      redirect_to project_path(@newproject.id)
    else
      flash[:error] = "Project not created because " + @newproject.errors.full_messages.join
      redirect_to user_path(params[:id])
    end
  end

  def create_invite
    if params[:commit] == t('welcome.submitbtn')
      flash[:success] = t('welcome.invitationFlash')
    else
      flash[:success] = t('welcome.publicBetaFlash')
    end
    redirect_to root_path
  end

  def index
    @users = User.paginate(page: params[:page], :order => 'LOWER(name) ASC')
  end

  def count
    render json: User.all.count
  end

  def edit
  end

  def update
    if params[:commit] == t('general.updatebtn')
      if @user.update_attributes(params[:user])
        flash[:success] = t('user.editSuccessmsg')
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    else
      User.find(params[:id]).destroy
      sign_out
      flash[:success] = t('user.editDeleteSuccessmsg')
      redirect_to root_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
