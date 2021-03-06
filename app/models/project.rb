class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(priority: :asc) }, dependent: :destroy

  validates :title, length: { maximum: 50 }, presence: true
  validates :title, uniqueness: { message: 'The project with such name does already exist.' }
end
