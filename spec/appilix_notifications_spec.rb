require_relative '../lib/appilix_notifications'

RSpec.describe AppilixNotifications do
  it 'sends a notification successfully using GET' do
    response = AppilixNotifications.appilix_send_notifications(
      AppilixNotifications::APP_KEY, AppilixNotifications::API_KEY, 'Hello', 'This is a test notification', nil, nil)

    expect(response).to be_a(Hash)
    expect(response['status']).to eq('true')
  end
end
