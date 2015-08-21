# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  language_key :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Language < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :translations

  validates :language_key, presence: true
end
