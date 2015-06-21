json.array!(@texts) do |text|
  json.extract! text, :id
  json.url text_url(text, format: :json)
end
