FactoryBot.define do
  factory :task do
    title { FFaker::Skill.tech_skill }
    priority { 1 }
    project
  end
end
