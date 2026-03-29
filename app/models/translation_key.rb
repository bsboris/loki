class TranslationKey < ApplicationRecord
  VALUE_TYPES = %w[text boolean integer float array plural].freeze

  belongs_to :project
  has_many :translations, dependent: :destroy

  enum :value_type, VALUE_TYPES.index_with(&:itself), validate: { allow_nil: true }

  validates :segment, :path_text, :path, presence: true
  validates :path_text, uniqueness: { scope: :project_id }
  validates :path, uniqueness: { scope: :project_id }
  validate :leaf_requires_value_type

  scope :leaves, -> { where(leaf: true) }
  scope :namespaces, -> { where(leaf: false) }

  private

  def leaf_requires_value_type
    if leaf? && value_type.blank?
      errors.add(:value_type, "must be present for leaf keys")
    elsif !leaf? && value_type.present?
      errors.add(:value_type, "must be blank for non-leaf keys")
    end
  end
end
