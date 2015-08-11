class RenameTypeInBuckets < ActiveRecord::Migration
  def change
    rename_column :buckets, :type, :kind
  end
end
