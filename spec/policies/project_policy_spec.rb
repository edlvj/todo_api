RSpec.describe ProjectPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :update?, :destroy? do
    context 'denies access' do
      let(:project) { build :project }

      it "if it's not user projects" do
        expect(subject).not_to permit(user, project)
      end
    end

    context 'grants access' do
      let(:project) { build :project, user: user }
      it "if it's user project" do
        expect(subject).to permit(user, project)
      end
    end
  end
end