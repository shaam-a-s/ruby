class Borrower < ApplicationRecord
  has_many :borrowings
  has_many :books, through: :borrowings
end