json.array!(@sub_buckets) do |sub_bucket|
  json.key sub_bucket.sub_bucket_name
  json.data sub_bucket.data_hash
end