describe ProjectSerializer, type: [:serializer] do
  let!(:project) { create(:project) }
  let(:serializer) { described_class.new(project, include: [:tasks]).serialized_json }

  subject { JSON.parse(serializer) }

  it 'has attributes' do
    expect(subject["data"]).to match({
        "attributes"=>{
            "id"=> project.id, "title"=>project.title
        },
        "id"=>project.id.to_s,
        "relationships"=>{
             "tasks"=>{
                 "data"=>[]
             }
        },
        "type"=>"project"
        }
     )
  end
end