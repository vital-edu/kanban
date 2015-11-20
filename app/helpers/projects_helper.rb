module ProjectsHelper
  def stages project
    tasks = project.stages
  end

  def stage_name stage
    Stage.find(stage).name
  end

  def stage_tasks (project, stage)
    project.tasks.where(stage_id: stage)
  end

end
