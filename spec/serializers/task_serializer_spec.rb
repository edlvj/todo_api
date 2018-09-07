describe TaskSerializer, type: [:serializer] do
  let!(:project) { create(:project) }
  let!(:task) { create :task, project: project }
  let(:serializer) { described_class.new(task).serialized_json }

  subject { JSON.parse(serializer) }

  it 'has attributes' do
    expect(subject["data"]).to match({
       "attributes"=>{
           "deadline"=>task.deadline, "done"=>task.done, "id"=>task.id, "priority"=>task.priority, "title"=> task.title
       },
       "id"=>task.id.to_s,
       "relationships"=>{
           "comments"=>{
               "data"=>[]
           }
       },
       "type"=>"task"
    })
  end
end