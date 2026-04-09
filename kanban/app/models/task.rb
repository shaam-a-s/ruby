class Task < ApplicationRecord
  belongs_to :project

  STATUSES = %w[todo ongoing completed]
  PRIORITIES = %w[low medium high]

  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }
  validates :name, presence: true
end
