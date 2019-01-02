RSpec.describe CommentPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :destroy?, :create? do
    context "denies access if it is not user projects" do
      let!(:project) { create :project }
      let!(:task) { create :task, project: project }
      let!(:comment) { create :comment, task: task }

      it "not permit" do
        expect(subject).not_to permit(user, comment)
      end
    end

    context "grants access if it is user project" do
      let!(:project) { create :project, user: user }
      let!(:task) { create :task, project: project }
      let!(:comment) { create :comment, task: task }

      it "permit" do
        expect(subject).to permit(user, comment)
      end
    end
  end
end