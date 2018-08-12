describe ProjectSerializer, type: [:serializer] do
  let(:project) { create(:project) }
  let(:serializer) { described_class.new(project) }

  subject { JSON.parse(serializer.object.to_json) }

  it 'has attributes' do
    expect(subject['id']).to eq project.id
    expect(subject['title']).to eq project.title
  end
end