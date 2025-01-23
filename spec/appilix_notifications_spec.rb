require_relative '../lib/appilix_notifications'

RSpec.describe AppilixNotifications do
  it 'sends a notification successfully using GET' do
    response = AppilixNotifications.appilix_send_notifications(
      AppilixNotifications::APP_KEY, AppilixNotifications::API_KEY, 'Hello', 'This is a test notification', nil, nil)

    expect(response).to be_a(Hash)
    expect(response['status']).to eq('true')
  end

  it 'fetches registered user tokens successfully with a valid page' do
    response = AppilixNotifications.appilix_registered_user_tokens(
      AppilixNotifications::APP_KEY, AppilixNotifications::API_KEY, 1)

    expect(response).to be_a(Hash)
    expect(response).to have_key('tokens')
    puts response
  end

  it 'raises an error when page is missing for registered user tokens' do
    expect {
      AppilixNotifications.appilix_registered_user_tokens(AppilixNotifications::APP_KEY, AppilixNotifications::API_KEY, nil)
    }.to raise_error(ArgumentError, 'Page parameter is mandatory')
  end
end
