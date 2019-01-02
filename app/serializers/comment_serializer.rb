class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :created_at

  attribute :attachment do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.attachment, disposition: "attachment", only_path:true) if object.attachment.attached?
  end
end