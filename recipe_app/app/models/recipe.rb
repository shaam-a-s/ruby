class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :ingredients, presence: true
end