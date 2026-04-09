class Repository < ApplicationRecord
  validates :provider, :namespace_path, :name, :default_base_ref, presence: true
  validates :name, uniqueness: { scope: %i[provider namespace_path] }
end
