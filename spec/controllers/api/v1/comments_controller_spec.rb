RSpec.describe Api::V1::CommentsController, type: :controller do
  before do
    request.headers.merge!(auth_header)
  end

  describe "POST #create" do
    let!(:project) { create :project, user: current_user }
    let!(:task) { create :task, project: project }

    context 'when user enter proper file format params' do
      let(:valid_params) {{ project_id: project.id, task_id: task.id, comment: attributes_for(:comment, :with_image_attachment) }}

      it 'return status 200' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user enter wrong file format params' do
      let(:valid_params) {{ project_id: project.id, task_id: task.id, comment: attributes_for(:comment, :with_text_attachment) }}
      let(:parsed_body) { JSON.parse(response.body) }

      it 'return status 200' do
        post :create, params: valid_params

        expect(parsed_body["errors"]).to eq(["Attachment Wrong file format. You can upload a *.jpg or *.png formats files only."])
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user delete own comment' do
      let!(:project) { create :project, user: current_user }
      let!(:task) { create :task, project: project }
      let!(:comment) { create :comment, task: task }

      it 'return status 200' do
        delete :destroy, params: { id: comment.id, project_id: project.id, task_id: task.id }
        expect(response).to have_http_status(:success)
      end

    end
  end
end
