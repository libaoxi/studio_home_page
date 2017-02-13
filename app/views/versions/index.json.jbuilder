json.array!(@versions) do |version|
  json.extract! version, :id, :update_apk_id,:state,:filename,:version
  json.url version_url(version, format: :json)
end
