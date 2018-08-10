RSpec.shared_context 'api', :api do
  let(:user) { create(:user) }
  let(:api_key) { JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base) }
end
