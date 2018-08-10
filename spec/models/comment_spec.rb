RSpec.describe Comment, type: :model do
  subject { build :comment }

  context 'association' do
    it { should belong_to :task }
  end

  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
  end
end
