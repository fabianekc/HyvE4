module ProjectsHelper
  def categorydata(project_id)
    @project = Project.find_by_id(project_id)
    
  end

  def categorytypes(item)
    ["Team Size", "Age", "Process", "Mentality", "Focus", "Impact", "Audience"][item]
  end

  def categoryoptions(item) 
    case item
      when "1"
        ["solo-show", "tiny", "small", "mid-size", "large", "huge", "global"]
      when "2"
        ["juvenile", "youngster", "adolescent", "grown-up", "mature", "senior", "Methuselah"]
      when "3"
        ["none", "chaotic", "scattered", "evolved", "standardized", "certified", "rigid"]
      when "4"
        ["party", "fun", "serene", "calm", "austere", "sober", "puritan"]
      when "5"
        ["greed", "money", "profit-oriented", "balanced", "social-oriented", "non-profit", "sacrificing"]
      when "6"
        ["isolated", "local", "regional", "community", "extensive", "global", "universal"]
      when "7"
        ["uniform", "homogen", "resemblent", "mixed", "varied", "heterogen", "diverse"]
    end
  end

  def similar_projects(currprojectid)
    require 'matrix'
    cpi = currprojectid.to_i
    pmat,idvec,cpvec,sp=[],[],[],[]
    Project.all(:joins => :pjattribs, :group => "projects.id").each do |p|
      vec=[]
      Pjattrib.find(:all, :conditions => ['project_id = ?', p.id]).each do |a|
        if p.id == cpi
          tvec = [0,0,0,0,0,0,1,0,0,0,0,0,0]
        else
          tvec = [1,2,3,4,5,6,7,6,5,4,3,2,1]
        end
        vec += tvec[7-a.attrvalue.to_i ... 14-a.attrvalue.to_i]
      end 
      if p.id == cpi
        cpvec << vec
      else
        idvec << p.id
        pmat << vec
      end
    end
    if pmat.size > 0
      b = Matrix.rows(cpvec) * Matrix.rows(pmat.transpose)
      d = b.to_a[0].zip(idvec).sort_by{ |e| -e.first }[0..4]
      d.each do |x|
        sp << [x[1], Project.find(x[1]).name, '%.0f' % ((x[0].to_f-7)/42*100)]
      end
      sp
    else
      [[]]
    end
  end
end
