RSpec.shared_context 'api', :api do
  let(:current_user) { create(:user) }
  let(:jwt_token) { JWT.encode({ user_id: current_user.id }, Rails.application.secrets.secret_key_base) }
  let(:auth_header) { ActiveSupport::HashWithIndifferentAccess.new({Authorization: "Bearer #{jwt_token}"})}
end
