class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :status, presence: true

  scope :completed, -> { where(status: "completed") }
  scope :pending, -> { where(status: "pending") }
end