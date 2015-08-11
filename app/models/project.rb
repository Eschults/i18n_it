# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  company_id   :integer
#  project_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#

class Project < ActiveRecord::Base
  belongs_to :company
  has_many :buckets
  has_and_belongs_to_many :languages

  validates :company, presence: true
  validates :project_name, presence: true
end
