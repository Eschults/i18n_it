# == Schema Information
#
# Table name: sub_buckets
#
#  id              :integer          not null, primary key
#  bucket_id       :integer
#  sub_bucket_name :string
#  uuid            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_sub_buckets_on_bucket_id  (bucket_id)
#

class SubBucket < ActiveRecord::Base
  belongs_to :bucket
  has_many :translations

  validates :bucket, presence: true
  validates :sub_bucket_name, presence: true
end
