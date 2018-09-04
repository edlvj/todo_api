class Comment < ApplicationRecord
  has_one_attached :attachment
  after_destroy :purge_attachment
  belongs_to :task

  validates :title, length: { maximum: 50 }, presence: true
  validate :attachment_mime_type
  validate :attachment_size

  private

  def purge_attachment
    self.attachment.purge if self.attachment.attached?
  end

  def attachment_size
    if attachment.attached? &&  attachment.blob.byte_size > 10000000
      attachment.purge
      errors.add(:attachment, 'An uploaded file is too large. The size shouldn’t exceed 10 MB.')
    end
  end

  def attachment_mime_type
    if attachment.attached? && !attachment.content_type.in?(%w(image/jpg image/png))
      attachment.purge
      errors.add(:attachment, 'Wrong file format. You can upload a *.jpg or *.png formats files only.')
    end
  end
end
