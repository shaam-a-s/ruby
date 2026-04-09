class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :borrower
end