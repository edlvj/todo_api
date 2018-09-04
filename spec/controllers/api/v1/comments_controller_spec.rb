RSpec.describe Api::V1::CommentsController, type: :controller do
  before do
    request.headers.merge!(auth_header)
  end

  # describe "POST #create" do
  #   context 'when user enter valid params' do
  #     let!(:project) { create :project, user: current_user }
  #     let!(:task) { create :task, project: project }
  #     let(:valid_params) {{ project_id: project.id, task_id: task.id, comment: attributes_for(:comment, :with_attachment) }}
  #     let(:parsed_body) { JSON.parse(response.body) }
  #
  #     it 'return status 200' do
  #       post :create, params: valid_params
  #       expect(response).to be_success
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    context 'when user delete own comment' do
      let!(:project) { create :project, user: current_user }
      let!(:task) { create :task, project: project }
      let!(:comment) { create :comment, task: task }

      it 'return status 200' do
        delete :destroy, params: { id: comment.id, project_id: project.id, task_id: task.id }
        expect(response).to be_success
      end

    end
  end
end
