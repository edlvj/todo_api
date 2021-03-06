FactoryBot.define do
  factory :project do
    title { FFaker::Skill.specialty }
    user
  end

  trait :with_tasks do
    tasks { create_list(:task, 2) }
  end
end
