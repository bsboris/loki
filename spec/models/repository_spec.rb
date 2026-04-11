require "rails_helper"

RSpec.describe Repository, type: :model do
  describe "validations" do
    it "requires provider, namespace_path, name, and default_base_ref" do
      repository = described_class.new(
        provider: nil,
        namespace_path: nil,
        name: nil,
        default_base_ref: nil
      )

      expect(repository).not_to be_valid
      expect(repository.errors[:provider]).to include("can't be blank")
      expect(repository.errors[:namespace_path]).to include("can't be blank")
      expect(repository.errors[:name]).to include("can't be blank")
      expect(repository.errors[:default_base_ref]).to include("can't be blank")
    end

    it "validates uniqueness of name scoped to provider and namespace_path" do
      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      duplicate = described_class.new(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "develop"
      )

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to include("has already been taken")
    end

    it "allows the same name under a different provider or namespace_path" do
      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      other_provider = described_class.new(
        provider: "gitlab",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )
      other_namespace = described_class.new(
        provider: "github",
        namespace_path: "acme/infra",
        name: "loki",
        default_base_ref: "main"
      )

      expect(other_provider).to be_valid
      expect(other_namespace).to be_valid
    end
  end

  describe "defaults" do
    it "defaults default_base_ref to main when omitted on create" do
      repository = described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki"
      )

      expect(repository.reload.default_base_ref).to eq("main")
    end
  end

  describe "#qualified_name" do
    it "joins namespace_path and name" do
      repository = described_class.new(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      expect(repository.qualified_name).to eq("acme/platform/loki")
    end
  end

  describe "database constraints" do
    it "enforces unique provider, namespace_path, and name at the database level" do
      described_class.create!(
        provider: "github",
        namespace_path: "acme/platform",
        name: "loki",
        default_base_ref: "main"
      )

      expect {
        described_class.insert!({
          provider: "github",
          namespace_path: "acme/platform",
          name: "loki",
          default_base_ref: "main",
          created_at: Time.current,
          updated_at: Time.current
        })
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
