require "rails_helper"

RSpec.describe Translation, type: :model do
  let(:project) { Project.create!(name: "Loki") }
  let(:other_project) { Project.create!(name: "Other") }
  let(:locale) { ProjectLocale.create!(project:, code: "en", default: true) }
  let(:other_locale) { ProjectLocale.create!(project: other_project, code: "de", default: true) }
  let(:leaf_key) do
    TranslationKey.create!(
      project:,
      segment: "title",
      path_text: "root.title",
      path: "root.title",
      leaf: true,
      value_type: "text"
    )
  end
  let(:namespace_key) do
    TranslationKey.create!(
      project:,
      segment: "root",
      path_text: "root",
      path: "root",
      leaf: false
    )
  end

  it "requires translations to reference leaf keys" do
    translation = described_class.new(
      translation_key: namespace_key,
      project_locale: locale,
      value: "Hello"
    )

    expect(translation).not_to be_valid
    expect(translation.errors[:translation_key]).to include("must reference a leaf key")
  end

  it "requires locale and key to belong to the same project" do
    translation = described_class.new(
      translation_key: leaf_key,
      project_locale: other_locale,
      value: "Hello"
    )

    expect(translation).not_to be_valid
    expect(translation.errors[:project_locale]).to include("must belong to the same project as the translation key")
  end

  it "validates value type against the key" do
    translation = described_class.new(
      translation_key: leaf_key,
      project_locale: locale,
      value: ["Hello"]
    )

    expect(translation).not_to be_valid
    expect(translation.errors[:value]).to include("must match text")
  end

  it "allows false for boolean keys" do
    boolean_key = TranslationKey.create!(
      project:,
      segment: "published",
      path_text: "root.published",
      path: "root.published",
      leaf: true,
      value_type: "boolean"
    )

    translation = described_class.new(
      translation_key: boolean_key,
      project_locale: locale,
      value: false
    )

    expect(translation).to be_valid
  end
end
