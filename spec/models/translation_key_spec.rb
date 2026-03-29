require "rails_helper"

RSpec.describe TranslationKey, type: :model do
  let(:project) { Project.create!(name: "Loki") }

  it "requires value_type for leaf keys" do
    key = described_class.new(
      project:,
      segment: "title",
      path_text: "root.title",
      path: "root.title",
      leaf: true
    )

    expect(key).not_to be_valid
    expect(key.errors[:value_type]).to include("must be present for leaf keys")
  end

  it "rejects value_type for non-leaf keys" do
    key = described_class.new(
      project:,
      segment: "root",
      path_text: "root",
      path: "root",
      leaf: false,
      value_type: "text"
    )

    expect(key).not_to be_valid
    expect(key.errors[:value_type]).to include("must be blank for non-leaf keys")
  end
end
