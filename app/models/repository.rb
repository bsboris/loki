class Repository < ApplicationRecord
  validates :provider, :namespace_path, :name, :default_base_ref, presence: true
  validates :name, uniqueness: { scope: %i[provider namespace_path] }

  def qualified_name
    "#{namespace_path}/#{name}"
  end
end
