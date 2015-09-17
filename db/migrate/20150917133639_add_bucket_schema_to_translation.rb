class AddBucketSchemaToTranslation < ActiveRecord::Migration
  def change
    add_reference :translations, :bucket_schema, index: true, foreign_key: true
  end
end
