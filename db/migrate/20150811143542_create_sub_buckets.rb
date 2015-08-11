class CreateSubBuckets < ActiveRecord::Migration
  def change
    create_table :sub_buckets do |t|
      t.references :bucket, index: true, foreign_key: true
      t.string :sub_bucket_name
      t.string :uuid

      t.timestamps null: false
    end
  end
end
