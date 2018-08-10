class Task < ApplicationRecord
  belongs_to :project
  has_many :comments

  acts_as_list scope: :project, column: :priority
  validates :title, length: { maximum: 50 }, presence: true
end
