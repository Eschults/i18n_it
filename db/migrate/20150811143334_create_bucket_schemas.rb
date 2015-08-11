class CreateBucketSchemas < ActiveRecord::Migration
  def change
    create_table :bucket_schemas do |t|
      t.references :bucket, index: true, foreign_key: true
      t.string :col_type
      t.string :bucket_schema_name

      t.timestamps null: false
    end
  end
end
