# == Schema Information
#
# Table name: buckets
#
#  id          :integer          not null, primary key
#  bucket_name :string
#  project_id  :integer
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_buckets_on_project_id  (project_id)
#

class Bucket < ActiveRecord::Base
  belongs_to :project
  has_many :bucket_schemas
  has_many :sub_buckets
  has_many :translations

  validates :project, presence: true
  validates :bucket_name, presence: true
  validates :type, presence: true
end
