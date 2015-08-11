class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :bucket_name
      t.references :project, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
