require "rails_helper"

RSpec.describe ProjectLocale, type: :model do
  it "allows only one default locale per project" do
    project = Project.create!(name: "Loki")
    ProjectLocale.create!(project:, code: "en", default: true)

    duplicate = ProjectLocale.new(project:, code: "de", default: true)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:default]).to include("already exists for this project")
  end
end
