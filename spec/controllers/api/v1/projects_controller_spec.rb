RSpec.describe Api::V1::ProjectsController, type: :controller do
  before do
    request.headers.merge!(auth_header)
  end

  describe "GET #index" do
    context 'when user have own project' do
      let!(:project) { create :project, user: current_user }
      let(:parsed_body) { JSON.parse(response.body) }

      it "return projects in json" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'when current user want to get projects of another user' do
      let!(:user) { create :user }
      let!(:project) { create :project, user: user }
      let(:parsed_body) { JSON.parse(response.body) }

      it "return empty projects in json" do
        get :index

        expect(parsed_body["data"]).to match([])
      end
    end
  end

  describe "POST #create" do
    context 'when user enter valid params' do
      let(:valid_params) { { project: attributes_for(:project) } }
      let(:parsed_body) { JSON.parse(response.body) }

      it 'return status 200' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end
      it 'create new project' do
        expect { post :create, params: valid_params }
            .to change { Project.count }.by(1)
      end

      it 'return project title in json body' do
        post :create, params: valid_params
        expect(parsed_body["data"]["attributes"]["title"]).to eq(valid_params[:project][:title])
      end
    end
  end

  describe "PUT #update" do
    context 'when user enter valid params' do
      let!(:project) { create :project, user: current_user }
      let(:valid_params) {{ id: project.id, project: attributes_for(:project) }}

      it 'returns a successful 200 response' do
        put :update, params: valid_params
        expect(response).to have_http_status(:success)
      end

      it 'update project' do
        expect { put :update, params: valid_params }
            .to change { project.reload.attributes }
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user delete own project' do
      let!(:project) { create :project, user: current_user }

      it 'return status 200' do
        delete :destroy, params: { id: project.id }
        expect(response).to have_http_status(:success)
      end

      it 'destroy project' do
        expect { delete :destroy, params: { id: project.id } }
            .to change { Project.count }.by(-1)
      end
    end

    context 'when user delete not own project' do
      let!(:user) { create :user }
      let!(:project) { create :project, user: user }

      it 'return status forbidden' do
        delete :destroy, params: { id: project.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end