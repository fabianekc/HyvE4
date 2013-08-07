include ActionView::Helpers::TextHelper

class StructuresController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_structure_user

  def show
    @structure = Structure.find(params[:id])
    @group = Group.find(@structure.group_id)
    @project = Project.find(@group.project_id)
    @datavals = Dataval.all(:conditions => ["structure_id = ?", params[:id]])
    a=[]
    b=[]
    Dataval.all(:conditions => ["structure_id = ?", @structure.id]).each do |r|
      a.push(r.value.to_i)
      b.push(r.valdatime)
    end

    @graph = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name => @structure.name, :data=> a)
      f.options[:xAxis][:categories] = b

    ###  Options for Bar
    ### f.options[:chart][:defaultSeriesType] = "bar"
    ### f.plot_options({:series=>{:stacking=>"normal"}}) 

    ## or options for column
    f.options[:chart][:defaultSeriesType] = "column"
    end
  end

  def create_data
    @structure = Structure.find(params['dataval']['structure_id'])
    @newdataval=@structure.datavals.build(valdatime: params['dataval']['valdatime'], value: params['dataval']['value'], comment: params['dataval']['comment'])
    if @newdataval.save
      flash[:success] = t('project.dataCreatedMsg')
    else
      flash[:error] = t('project.dataCreationErrorMsg') + @newdataval.errors.full_messages.join
    end
    redirect_to structure_path(params[:id])
  end

  def update_dataval
    @dataval = Dataval.find(params['dataval']['id'])
    sid = @dataval.structure_id
    if params[:commit] == t('general.updatebtn')
      if @dataval.update_attributes(params[:dataval])
        flash[:success] = t('project.dataEditMsg')
      else
        flash[:error] = t('project.dataEditErrorMsg') + @dataval.errors.full_messages.join
      end
    else
      @dataval.destroy
      flash[:success] = t('project.dataDeleteMsg')
    end
    redirect_to structure_path(sid)
  end

  private
    def correct_structure_user
      @structure = Structure.find(params[:id])
      @group = Group.find(@structure.group_id)
      @project = Project.find(@group.project_id)
      correct_user(@project)
    end

end
