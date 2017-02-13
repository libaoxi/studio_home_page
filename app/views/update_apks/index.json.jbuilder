json.array!(@update_apks) do |update_apk|
  json.extract! update_apk, :id, :name, :uuid
  json.url update_apk_url(update_apk, format: :json)
end
