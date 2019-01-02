User.find_or_create_by!(username: 'test') do |user|
  user.password = '11111111'
end

User.find_each do |user|
  5.times do
    project = Project.create!(
      title: FFaker::Job.title,
      user: user
    )

    rand(2..10).times do
      Task.create! do |task|
        task.title = FFaker::Job.title
        task.project_id = project.id
      end
    end
  end
end