class Donation < ApplicationRecord
  belongs_to :project

  validates :amount, presence: true
end