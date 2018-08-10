RSpec.describe AuthorizeApiRequest, type: [:command] do
  describe '.call' do

    context 'when user is valid' do
      let!(:user) { create(:user) }
      let(:headers) { {Authorization: "Bearer #{JsonWebToken.encode(user_id: user.id).result}"}}

      it 'returns true when user present' do
        raise headers.inspect
        expect(
          AuthorizeApiRequest.new(headers).call
        ).to be_truthy
      end
    end
  end
end