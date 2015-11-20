module ProjectsHelper
  def stages project
    tasks = project.tasks.select(:stage_id).uniq
    stages = Array.new
    tasks.each do |t|
      stages.push(t[:stage_id])
    end
    stages
  end

  def stage_name stage
    Stage.find(stage).name
  end

  def stage_tasks (project, stage)
    project.tasks.where(stage_id: stage)
  end

end
