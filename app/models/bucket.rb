# == Schema Information
#
# Table name: buckets
#
#  id          :integer          not null, primary key
#  bucket_name :string
#  project_id  :integer
#  kind        :string
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
  validates :kind, presence: true
  validates :kind, inclusion: ["s", "d"]

  def cross_languages_bucket_schemas
    bucket_schemas.where(cross_languages: true)
  end

  def other_bucket_schemas
    bucket_schemas - cross_languages_bucket_schemas
  end
end
