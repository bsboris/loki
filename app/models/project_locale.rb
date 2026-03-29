class ProjectLocale < ApplicationRecord
  belongs_to :project
  has_many :translations, dependent: :destroy

  validates :code, presence: true, uniqueness: { scope: :project_id }
  validate :single_default_locale_per_project

  private

  def single_default_locale_per_project
    return unless default?
    return unless project

    existing_default = project.project_locales.where(default: true).where.not(id: id)
    return unless existing_default.exists?

    errors.add(:default, "already exists for this project")
  end
end
