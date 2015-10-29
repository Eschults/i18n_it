# == Schema Information
#
# Table name: translations
#
#  id               :integer          not null, primary key
#  translation_key  :string
#  text             :text
#  bucket_id        :integer
#  sub_bucket_id    :integer
#  language_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  bucket_schema_id :integer
#
# Indexes
#
#  index_translations_on_bucket_id         (bucket_id)
#  index_translations_on_bucket_schema_id  (bucket_schema_id)
#  index_translations_on_language_id       (language_id)
#  index_translations_on_sub_bucket_id     (sub_bucket_id)
#

class Translation < ActiveRecord::Base
  belongs_to :bucket
  belongs_to :sub_bucket
  belongs_to :bucket_schema
  belongs_to :language

  validates :translation_key, presence: true
  # validates :text, presence: true
  validates :bucket, presence: true
  validates :language, presence: true

  def translations_including_self_in_array
    output = []
    bucket.project.languages.each do |language|
      output << Translation.find_by(language: language, bucket: bucket, translation_key: translation_key, sub_bucket: sub_bucket) if Translation.find_by(language: language, bucket: bucket, translation_key: translation_key, sub_bucket: sub_bucket)
    end
    output
  end

  def cross_languages?
    bucket_schema.cross_languages ? true : false
  end

  def translations_including_self_in_hash
    output = {}
    translations_including_self_in_array.each do |translation|
      output[translation.language.language_key] = translation.text
    end
    output
  end

  def translations_including_self_in_super_hash
    output = {}
    translations_including_self_in_array.each do |translation|
      output[translation.language.language_key] = {}
      output[translation.language.language_key][translation_key] = translation.text
    end
    output
  end
end
