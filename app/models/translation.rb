class Translation < ApplicationRecord
  belongs_to :translation_key
  belongs_to :project_locale

  validates :project_locale_id, uniqueness: { scope: :translation_key_id }
  validate :value_must_be_set
  validate :translation_key_must_be_leaf
  validate :locale_and_key_must_belong_to_same_project
  validate :value_matches_key_type

  private

  def value_must_be_set
    return unless value.nil?

    errors.add(:value, "must be set")
  end

  def translation_key_must_be_leaf
    return unless translation_key
    return if translation_key.leaf?

    errors.add(:translation_key, "must reference a leaf key")
  end

  def locale_and_key_must_belong_to_same_project
    return unless translation_key && project_locale
    return if translation_key.project_id == project_locale.project_id

    errors.add(:project_locale, "must belong to the same project as the translation key")
  end

  def value_matches_key_type
    return unless translation_key&.value_type.present?

    valid = case translation_key.value_type
    when "text"
      value.is_a?(String)
    when "boolean"
      value == true || value == false
    when "integer"
      value.is_a?(Integer)
    when "float"
      value.is_a?(Numeric)
    when "array"
      value.is_a?(Array)
    when "plural"
      value.is_a?(Hash)
    else
      false
    end

    return if valid

    errors.add(:value, "must match #{translation_key.value_type}")
  end
end
