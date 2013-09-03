include ActionView::Helpers::TextHelper
include ActionView::Helpers::JavaScriptHelper
require("cgi")

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
      flash[:success] = t('project.created')
      flash[:info] = t('project.createdHint')
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
    @groups = Group.all(:conditions => "project_id=" + params[:id], :order => "created_at ASC")
    if flash[:info].nil?
      if Structure.where(:group_id => Group.select("id").where(project_id: @project.id)).count == 0 && current_project_user?(@project) 
        flash[:info] = t('project.datastructHint')
      end
    end
  end

  def update_email
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
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
      if params[:commit] == t('project.categoryNext')
        redirect_to :action => 'category', :page => params[:page].to_i + 1
      elsif params[:commit] == t('project.categoryPrev')
        redirect_to :action => 'category', :page => params[:page].to_i - 1
      else params[:commit] == t('project.categoryFinish')
        @project = Project.find(params[:id])
        redirect_to project_path(@project)
      end
    else
      redirect_to :action => 'category'
    end
  end

  def template
    @project = Project.find(params[:id])
    flash[:info] = nil
  end

  def choose_template
    if params[:commit] == t('project.categoryNext')
      redirect_to :action => 'groups', :template => params[:template][:selection]
    else
      @project = Project.find(params[:id])
      redirect_to project_path(@project)
    end
  end

  def groups
    @project = Project.find(params[:id])
    @tg = TemplateGroup.where('templateid = ? AND lang = ?', params[:template], locale.to_s)

  end

  def select_groups
    @project = Project.find(params[:id])
    if params[:commit] == t('project.categoryFinish')
      @tg = TemplateGroup.where('templateid = ? AND lang = ?', params[:template], locale.to_s)
      @tg.each do |group|
        if !params[group.groupname.to_s].nil?
          @newgroup=@project.groups.build(name: group.groupname.to_s, comment: "from template '" + group.templatename + "'")
          if @newgroup.save
            @gi = GroupItem.where('groupname = ? AND lang = ?', group.groupname, locale.to_s)
            @gi.each do |item|
              @newitem=@newgroup.structures.build(name: item.itemname.to_s, comment: item.description.to_s)
              @newitem.save
            end
          end
        end
      end
      flash[:success] = "Groups for template '" + params[:template] + "' created."
      redirect_to project_path(@project)
    elsif params[:commit] == t('project.categoryPrev')
      redirect_to :action => 'template'
    else
      redirect_to project_path(@project)
    end

  end

  def create_group
    @project = Project.find(params[:id])
    if current_project_user?(@project)
      @newgroup=@project.groups.build(name: params['group']['name'], comment: params['group']['comment'])
      if @newgroup.save
        flash[:success] = t('project.groupCreatedMsg')
      else
        flash[:error] = t('project.groupCreationErrorMsg') + @newgroup.errors.full_messages.join
      end
    end
    redirect_to project_path(params[:id])
  end

  def update_group
    @group = Group.find(params['group']['id'])
    @project = Project.find(@group.project_id)
    if current_project_user?(@project)
      pid = @group.project_id
      if params[:commit] == t('general.updatebtn')
        if @group.update_attributes(params[:group])
          flash[:success] = t('project.groupEditMsg')
        else
          flash[:error] = t('project.groupEditErrorMsg') + @group.errors.full_messages.join 
        end
      else
        @group.destroy
        flash[:success] = t('project.groupDeleteMsg')
      end
    end
    redirect_to project_path(pid)
  end

  def create_structure
    @group = Group.find(params['myform']['group_id'])
    @project = Project.find(@group.project_id)
    if current_project_user?(@project)
      @newstructure = @group.structures.build(name: params['myform']['name'], comment: params['myform']['comment'])
      if @newstructure.save
        flash[:success] = t('project.itemCreatedMsg')
      else
        flash[:error] = t('project.itemCreationErrorMsg') + @newstructure.errors.full_messages.join
      end
    end
    redirect_to project_path(params[:id])
  end

  def update_structure
    @structure = Structure.find(params['mystructure']['id'])
    @group = Group.find(@structure.group_id)
    @project = Project.find(@group.project_id)
    if current_project_user?(@project)
      pid = params[:id]
      if params[:commit] == t('general.updatebtn')
        if @structure.update_attributes(params[:mystructure])
          flash[:success] = t('project.itemEditMsg')
        else
          flash[:error] = t('project.itemEditErrorMsg') + @structure.errors.full_messages.join
        end
      else
        @structure.destroy
        flash[:success] = t('project.itemDeleteMsg')
      end
    end
    redirect_to project_path(pid)
  end

  def create_data
    @structure = Structure.find(params['dataval']['structure_id'])
    @group = Group.find(@structure.group_id)
    @project = Project.find(@group.project_id)
    if current_project_user?(@project)
      @newdataval=@structure.datavals.build(valdatime: params['dataval']['valdatime'], value: params['dataval']['value'], comment: params['dataval']['comment'])
      if @newdataval.save
        flash[:success] = t('project.dataCreatedMsg')
      else
        flash[:error] = t('project.dataCreationErrorMsg') + @newdataval.errors.full_messages.join
      end
    end
    redirect_to project_path(params[:id])
  end

  def index
    @projects = Project.paginate(page: params[:page])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if params[:commit] == t('general.updatebtn')
      if @project.update_attributes(params[:project])
        flash[:success] = t('project.editSuccessmsg')
        redirect_to @project
      else
        render 'edit'
      end
    else
      @user = User.find(@project.user_id)
      @project.destroy
      flash[:success] = t('project.editDeleteSuccessmsg')
      redirect_to @user
    end
  end

  def destroy
    myuser = Project.find(params[:id]).user_id
    Project.find(params[:id]).destroy
    flash[:success] = t('project.editDeleteSuccessmsg')
    if current_user.admin?
      redirect_to projects_path
    else
      redirect_to user_path(myuser)
    end
  end

  private
    def correct_project_user
      @project = Project.find(params[:id])
      if !current_project_user?(@project) && !current_user.admin?
        flash[:error] = t('project.editInvalidUser')
        redirect_to(root_path)
      end
    end
end
