class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :title, presence: true
end