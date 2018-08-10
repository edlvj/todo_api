RSpec.describe AuthenticateUser, type: [:command] do
  describe '.call' do

    context 'when user is valid' do
      let!(:user) { create(:user) }

      it 'returns true when user present' do
        expect(
          AuthenticateUser.new(user.username, "password").call
        ).to be_truthy
      end
    end

    context 'when user is enter invalid' do
      it 'returns false' do
        expect(
          AuthenticateUser.new("user", "password").call.errors
        ).not_to be_empty
      end
    end
  end
end