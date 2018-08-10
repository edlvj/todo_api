RSpec.describe User, type: :model do
  subject { build :user }

  context 'association' do
    it { should have_many :projects }
  end

  context 'validation' do
    it { should validate_presence_of(:username) }
  end
end
