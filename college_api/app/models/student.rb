# Student model with validations and search scope

class Student < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :course, presence: true
  validates :year_of_study, presence: true, numericality: { only_integer: true }

  scope :by_course, ->(course) { where(course: course) }
end