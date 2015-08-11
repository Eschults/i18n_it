# == Schema Information
#
# Table name: translations
#
#  id              :integer          not null, primary key
#  translation_key :string
#  text            :text
#  bucket_id       :integer
#  sub_bucket_id   :integer
#  language_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_translations_on_bucket_id      (bucket_id)
#  index_translations_on_language_id    (language_id)
#  index_translations_on_sub_bucket_id  (sub_bucket_id)
#

class Translation < ActiveRecord::Base
  belongs_to :bucket
  belongs_to :sub_bucket
  belongs_to :language

  validates :translation_key, presence: true
  validates :text, presence: true
  validates :bucket, presence: true
  validates :language, presence: true
end
