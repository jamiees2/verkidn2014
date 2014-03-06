json.array!(@projects) do |work|
  json.extract! work, :id, :name, :description, :status_id
  json.url projects_url(work, format: :json)
end
