class ContactPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id title content email phone address created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
