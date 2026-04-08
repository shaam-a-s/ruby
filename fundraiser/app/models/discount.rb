class Discount < ApplicationRecord
  belongs_to :project

  validates :code, presence: true
  validates :percentage, presence: true
end