FactoryBot.define do
  factory :task do
    title { FFaker::CoursesFR::Mathematiques.lesson }
    priority 1
    project
  end
end
