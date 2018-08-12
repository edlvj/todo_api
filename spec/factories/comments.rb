FactoryBot.define do
  factory :comment do
    title { FFaker::Product.product_name}
    task
  end

  trait :with_attachment do
    attachment { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.txt") }
  end
end
