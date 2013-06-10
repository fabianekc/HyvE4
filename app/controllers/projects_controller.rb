class ProjectsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_project_user, only: [:edit, :update, :destroy]

  def create
    @project = current_user.projects.build(params[:project])
    @projects = current_user.projects
    @posting = current_user.postings.build
    @postings = current_user.postings
    @feed_items = []
    if @project.save
      flash[:success] = "Project created!"
      redirect_to project_path(@project.id)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'users/new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @user = User.find_by_id(@project.user_id)
    @categories = Pjattrib.all(:conditions => "project_id=" + params[:id] + " and attrtype>0 and attrtype<8", :order => "attrtype ASC")
  end

  def category
    @project = Project.find(params[:id])
    if Pjattrib.where("project_id = " + @project.id.to_s + " AND attrtype >= 1 and attrtype <=7").count != 7
      7.times do |i|
        if Pjattrib.where("project_id = " + @project.id.to_s + " AND attrtype = " + (i+1).to_s).count != 1
          tmp = @project.pjattribs.build(attrtype: i+1, attrvalue: "4")
          tmp.save
        end
      end
    end
    @pjattrib = Pjattrib.where("project_id = " + @project.id.to_s + " AND attrtype = " + params[:page].to_s).first
  end

  def update_category
    @pjattrib = Pjattrib.where("project_id = " + params[:id].to_s + " AND attrtype = " + params[:page].to_s).first
    if @pjattrib.update_attributes(params[:pjattrib])
      if params[:commit] == 'Next'
        redirect_to :action => 'category', :page => params[:page].to_i + 1
      elsif params[:commit] == 'Previous'
        redirect_to :action => 'category', :page => params[:page].to_i - 1
      else params[:commit] == 'Finished'
        @project = Project.find(params[:id])
        redirect_to project_path(@project)
      end
    else
      redirect_to :action => 'category'
    end
  end

  def index
    @projects = Project.paginate(page: params[:page])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    myuser = Project.find(params[:id]).user_id
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted."
    redirect_to user_path(myuser)
  end

  private
    def correct_project_user
      @project = Project.find(params[:id])
      if !current_project_user?(@project)
        flash[:error] = 'You are not the owner of this project!'
        redirect_to(root_path)
      end
    end
end
