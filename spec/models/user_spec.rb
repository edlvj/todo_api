RSpec.describe User, type: :model do
  subject { create :user, username: "test" }

  context 'association' do
    it { should have_many :projects }
  end

  context 'validation' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity.with_message('This login is already registered. Please, log in.') }
  end
end
