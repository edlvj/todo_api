RSpec.describe Api::V1::TasksController, type: :controller do
  before do
    request.headers.merge!(auth_header)
  end

  describe "POST #create" do
    context 'when user enter valid params' do
      let!(:project) { create :project, user: current_user }
      let(:valid_params) {{ project_id: project.id, task: attributes_for(:task) }}
      let(:parsed_body) { JSON.parse(response.body) }

      it 'return status 200' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    context 'when user enter valid params' do
      let!(:project) { create :project, user: current_user }
      let!(:task) { create :task, project: project }
      let(:valid_params) {{ project_id: project.id, id: task.id, task: attributes_for(:task) }}

      it 'returns a successful 200 response' do
        put :update, params: valid_params
        expect(response).to have_http_status(:success)
      end

      it 'update project' do
        expect { put :update, params: valid_params }
          .to change { task.reload.attributes }
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user delete own task' do
      let!(:project) { create :project, user: current_user }
      let!(:task) { create :task, project: project }

      it 'return status 200' do
        delete :destroy, params: { project_id: project.id, id: task.id }
        expect(response).to have_http_status(:success)
      end

      it 'destroy task' do
        expect { delete :destroy, params: { project_id: project.id, id: task.id } }
            .to change { Task.count }.by(-1)
      end
    end

    context 'when user delete not own project' do
      let!(:user) { create :user }
      let!(:project) { create :project, user: user }
      let!(:task) { create :task, project: project }

      it 'return status forbidden' do
        delete :destroy, params: { project_id: project.id, id: task.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
