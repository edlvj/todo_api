FactoryBot.define do
  factory :comment do
    title { FFaker::Product.product_name}
    task
  end

  trait :with_text_attachment do
    attachment { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.txt") }
  end

  trait :with_image_attachment do
    attachment { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.png") }
  end
end
