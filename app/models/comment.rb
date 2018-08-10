class Comment < ApplicationRecord
  belongs_to :task

  validates :title, length: { maximum: 50 }, presence: true
end
