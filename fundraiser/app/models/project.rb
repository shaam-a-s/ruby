class Project < ApplicationRecord
  has_many :donations, dependent: :destroy
  has_many :discounts, dependent: :destroy

  validates :name, presence: true
  validates :goal, presence: true
end