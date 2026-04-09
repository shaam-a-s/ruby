class Book < ApplicationRecord
  has_many :borrowings
  has_many :borrowers, through: :borrowings
end