# frozen_string_literal: true

RSpec.describe API::V2::Endpoints::Tasks, type: :request do

  describe 'POST #create' do
    context 'when user have own project' do
      let!(:project) { create :project, user: current_user }
      let(:valid_params) {{ project_id: project.id, task: attributes_for(:task) }}
      let(:parsed_body) { JSON.parse(response.body) }

      it 'return projects in json' do
        post "/api/v2/projects/#{project.id}/tasks", params: valid_params, headers: auth_header
        p response.body
        expect(response.status).to eq(200)
      end
    end
  end

  # describe "PUT #update" do
  #   context 'when user enter valid params' do
  #     let!(:project) { create :project, user: current_user }
  #     let!(:task) { create :task, project: project }
  #     let(:valid_params) {{ project_id: project.id, id: task.id, task: attributes_for(:task) }}
  #
  #     it 'returns a successful 200 response' do
  #       put "/api/v2/projects/#{project.id}/tasks/#{task.id}", params: valid_params, headers: auth_header
  #       expect(response).to have_http_status(:success)
  #     end
  #
  #     it 'update task' do
  #       expect { put "/api/v2/projects/#{project.id}/tasks/#{task.id}", params: valid_params, headers: auth_header }
  #         .to change { project.reload.attributes }
  #     end
  #   end
  # end
end