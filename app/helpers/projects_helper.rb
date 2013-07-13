include ActionView::Helpers::TextHelper

module ProjectsHelper
  def categorydata(project_id)
    @project = Project.find_by_id(project_id)
  end

  def categorytypes(item)
    [t('project.categoryTeamSize'), t('project.categoryAge'), t('project.categoryProcess'), t('project.categoryMentality'), t('project.categoryFocus'), t('project.categoryImpact'), t('project.categoryAudience')][item]
  end

  def categoryimg(item)
    ["team", "age", "process", "mentality", "focus", "impact", "audience"][item]
  end

  def categoryoptions(item) 
    case item
      when "1"
        [t('project.categoryTeam1'), t('project.categoryTeam2'), t('project.categoryTeam3'), t('project.categoryTeam4'), t('project.categoryTeam5'), t('project.categoryTeam6'), t('project.categoryTeam7')]
      when "2"
        [t('project.categoryAge1'), t('project.categoryAge2'), t('project.categoryAge3'), t('project.categoryAge4'), t('project.categoryAge5'), t('project.categoryAge6'), t('project.categoryAge7')]
      when "3"
        [t('project.categoryProcess1'), t('project.categoryProcess2'), t('project.categoryProcess3'), t('project.categoryProcess4'), t('project.categoryProcess5'), t('project.categoryProcess6'), t('project.categoryProcess7')]
      when "4"
        [t('project.categoryMentality1'), t('project.categoryMentality2'), t('project.categoryMentality3'), t('project.categoryMentality4'), t('project.categoryMentality5'), t('project.categoryMentality6'), t('project.categoryMentality7')]
      when "5"
        [t('project.categoryFocus1'), t('project.categoryFocus2'), t('project.categoryFocus3'), t('project.categoryFocus4'), t('project.categoryFocus5'), t('project.categoryFocus6'), t('project.categoryFocus7')]
      when "6"
        [t('project.categoryImpact1'), t('project.categoryImpact2'), t('project.categoryImpact3'), t('project.categoryImpact4'), t('project.categoryImpact5'), t('project.categoryImpact6'), t('project.categoryImpact7')]
      when "7"
        [t('project.categoryAudience1'), t('project.categoryAudience2'), t('project.categoryAudience3'), t('project.categoryAudience4'), t('project.categoryAudience5'), t('project.categoryAudience6'), t('project.categoryAudience7')]
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
          tvec = [0,0,0,1,4,9,16,9,4,1,0,0,0]
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
    if pmat.size > 0 and cpvec.size > 0
      b = Matrix.rows(cpvec) * Matrix.rows(pmat.transpose)
      d = b.to_a[0].zip(idvec).sort_by{ |e| -e.first }[0..4]
      d.each do |x|
        if x[0] > 6
          sp << [x[1], Project.find(x[1]).name, '%.0f' % ((x[0].to_f)/1.12)]
        end
      end
      sp
    else
      0
    end
  end
end
