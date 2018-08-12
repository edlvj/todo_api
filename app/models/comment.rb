class Comment < ApplicationRecord
  has_one_attached :attachment
  after_destroy :purge_attachment
  belongs_to :task

  validates :title, length: { maximum: 50 }, presence: true

  def purge_attachment
    self.attachment.purge if self.attachment.attached?
  end
end
