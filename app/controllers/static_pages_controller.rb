class StaticPagesController < ApplicationController
  def imprint
  end

  def about
  end

  def plans
  end

  def tour
  end

  def statistic
    @datavals = Dataval.group("DATE_TRUNC('week', valdatime)").count.sort
    a=[]
    b=[]
    cnt=0
    @datavals.each do |r|
      cnt += r[1]
      a.push(cnt)
      b.push(Date.strptime(r[0]).strftime("%F"))
    end
    @graph = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name => "# Data Items", :data=> a)
      f.options[:xAxis][:categories] = b
      f.options[:chart][:defaultSeriesType] = "column"
    end
    @datavals = b.zip(a)
  end
end
