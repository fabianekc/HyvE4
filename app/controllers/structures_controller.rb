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
    Dataval.all(:conditions => ["structure_id = 5"]).each do |r|
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
      flash[:success] = "Data added"
    else
      flash[:error] = "No data added because " + @newdataval.errors.full_messages.join
    end
    redirect_to structure_path(params[:id])
  end

  def update_dataval
    @dataval = Dataval.find(params['dataval']['id'])
    sid = @dataval.structure_id
    if params[:commit] == "Update"
      if @dataval.update_attributes(params[:dataval])
        flash[:success] = "Data item updated"
      else
        flash[:error] = "Date item not updated because " + @dataval.errors.full_messages.join
      end
    else
      @dataval.destroy
      flash[:success] = "Data item deleted"
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
