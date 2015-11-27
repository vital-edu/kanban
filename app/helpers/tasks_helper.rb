module TasksHelper
  def select_stage(task)
    task.project.stages.collect { |s| [ s.name, s.id ] }
  end
end
