json.array!(@translations_grouped_by_key) do |translation|
  json.ids translation.translations_including_self_in_array.map { |t| t.id }
  json.translation_key translation.translation_key
  json.bucket_name translation.bucket.bucket_name
  json.project_name translation.bucket.project.project_name
  json.company_name translation.bucket.project.company.company_name
  json.translations translation.translations_including_self_in_hash
end