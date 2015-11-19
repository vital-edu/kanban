json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :start_date, :end_date, :progress
  json.url project_url(project, format: :json)
end
