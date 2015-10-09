json.array!(@translations) do |translation|
  json.ids translation[:ids]
  json.translation_key translation[:translation_key]
  json.sub_bucket_name translation[:sub_bucket_name] if translation[:sub_bucket_name]
  json.bucket_name translation[:bucket_name]
  json.project_name translation[:project_name]
  json.company_name translation[:company_name]
  json.translations translation[:translations]
end