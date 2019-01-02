RSpec.describe TaskPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :update?, :destroy?, :create? do
    context "denies access if it is not user projects" do
      let!(:project) { create :project }
      let!(:task) { create :task, project: project }

      it "not permit" do
        expect(subject).not_to permit(user, task)
      end
    end

    context "grants access if it is user project" do
      let!(:project) { create :project, user: user }
      let!(:task) { create :task, project: project }

      it "permit" do
        expect(subject).to permit(user, task)
      end
    end
  end
end