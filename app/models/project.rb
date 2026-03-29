class Project < ApplicationRecord
  has_many :project_locales, dependent: :destroy
  has_many :translation_keys, dependent: :destroy

  validates :name, presence: true
end
