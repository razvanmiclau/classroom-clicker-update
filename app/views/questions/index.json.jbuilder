json.array!(@questions) do |question|
  json.extract! question, :id, :title, :type, :topic_id
  json.url question_url(question, format: :json)
end
