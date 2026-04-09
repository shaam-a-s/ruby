class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :lessons, dependent: :destroy

  validates :name, :instructor, presence: true
end
