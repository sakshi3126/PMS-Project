json.extract! task, :id, :name, :description, :task_status, :task_date, :project_id, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
