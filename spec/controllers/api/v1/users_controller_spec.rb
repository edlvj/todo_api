RSpec.describe Api::V1::UsersController, type: :controller do

  describe "POST #sign_in" do
    let!(:user) { create :user }
    context "when user enter valid params" do
      let(:valid_params) {{  username: user.username, password: "password"}}

      it "returns http success" do
        post :sign_in, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end

    context "when user enter invalid password" do
      let(:invalid_params) {{  username: user.username, password: "qoose"} }

      it "returns http success" do
        post :sign_in, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #sign_up" do
    context "when user enter valid params" do
      let(:valid_params) {{ username: "daddy", password: "password"} }

      it "returns http created" do
        post :sign_up, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "when user enter invalid params" do
      let(:invalid_params) { {  username: "", password: ""}  }

      it "returns http unprocessable_entity" do
        post :sign_up, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
