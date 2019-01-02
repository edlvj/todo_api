RSpec.describe AuthorizeApiRequest, type: [:command] do
  describe '.call' do
    context 'when Authorization headers is not present' do
      let!(:user) { create(:user) }
      let(:jwt_token) { "invalid token" }
      let(:command) { AuthorizeApiRequest.new({}).call }

      it 'returns error' do
        expect(
          command.errors
        ).not_to be_empty
      end
    end

    context 'when Authorization headers is present' do
      let!(:user) { create(:user) }
      let(:jwt_token) { JsonWebToken.encode(user_id: user.id) }
      let(:headers) { ActiveSupport::HashWithIndifferentAccess.new({Authorization: "Bearer #{jwt_token}"})}
      let(:command) { AuthorizeApiRequest.new(headers).call }

      it 'returns true when user present' do
        expect(
          command.result
        ).to eq(user)
      end
    end
  end
end