class AddCrossLanguagesToBucketSchemas < ActiveRecord::Migration
  def change
    add_column :bucket_schemas, :cross_languages, :boolean
  end
end
