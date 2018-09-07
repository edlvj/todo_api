describe CommentSerializer, type: [:serializer] do
  let!(:project) { create(:project) }
  let!(:task) { create :task, project: project }
  let!(:comment) { create :comment, task: task }

  let(:serializer) { described_class.new(comment).serialized_json }

  subject { JSON.parse(serializer) }

  it 'has attributes' do
    expect(subject["data"]).to match({
        "attributes"=>{
             "attachment"=>nil, "created_at"=>comment.created_at.to_s, "id"=> comment.id , "title"=>comment.title
        },
        "id"=>comment.id.to_s,
        "type"=>"comment"
    })
  end
end