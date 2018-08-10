RSpec.describe Project, type: :model do
  subject { build :project }

  context 'association' do
    it { should belong_to :user }
    it { should have_many :tasks }
  end

  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(50) }
    it {  validate_uniqueness_of(:username) }
  end
end
