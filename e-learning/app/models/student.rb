class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
