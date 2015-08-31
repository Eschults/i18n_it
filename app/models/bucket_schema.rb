# == Schema Information
#
# Table name: bucket_schemas
#
#  id                 :integer          not null, primary key
#  bucket_id          :integer
#  col_type           :string
#  bucket_schema_name :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_bucket_schemas_on_bucket_id  (bucket_id)
#

class BucketSchema < ActiveRecord::Base
  belongs_to :bucket

  validates :bucket, presence: true

  def slug
    bucket_schema_name.downcase.gsub(' ', '_')
  end
end
