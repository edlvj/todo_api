# frozen_string_literal: true

RSpec.describe API::V2::Endpoints::Project, type: :request do

  describe "GET #index" do
    context 'when user have own project' do
      let!(:project) { create :project, user: current_user }

      it 'return projects in json' do
        get '/api/v2/projects', headers: auth_header
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST #create" do
    context 'when user enter valid params' do
      let(:valid_params) { { project: attributes_for(:project) } }
      let(:parsed_body) { JSON.parse(response.body) }

      it 'return status 200' do
        post '/api/v2/projects', params: valid_params, headers: auth_header
        p response.body
        expect(response).to have_http_status(:success)
      end

      it 'create new project' do
        expect { post '/api/v2/projects', params: valid_params, headers: auth_header }
          .to change { Project.count }.by(1)
      end

      it 'return project title in json body' do
        post '/api/v2/projects', params: valid_params, headers: auth_header
        expect(parsed_body["title"]).to eq(valid_params[:project][:title])
      end
    end
  end

  describe "PUT #update" do
    context 'when user enter valid params' do
      let!(:project) { create :project, user: current_user }
      let(:valid_params) {{ id: project.id, project: attributes_for(:project) }}

      it 'returns a successful 200 response' do
        put "/api/v2/projects/#{project.id}", params: valid_params, headers: auth_header
        expect(response).to have_http_status(:success)
      end

      it 'update project' do
        expect { put "/api/v2/projects/#{project.id}", params: valid_params, headers: auth_header }
          .to change { project.reload.attributes }
      end
    end
  end

end