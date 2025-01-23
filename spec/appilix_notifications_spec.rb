require_relative '../lib/appilix_notifications'

RSpec.describe AppilixNotifications do
  app_key = "key1"
  api_key = "apikey1"

  it 'sends a notification successfully using GET' do
    allow(AppilixNotifications).to receive(:appilix_send_notifications)
      .with(app_key, api_key, 'Hello', 'This is a test notification', nil, nil).and_return({ 'status' => 'true' })

    response = AppilixNotifications.appilix_send_notifications(
      app_key, api_key, 'Hello', 'This is a test notification', nil, nil
    )

    expect(response).to be_a(Hash)
    expect(response['status']).to eq('true')
  end

  it 'fetches registered user tokens successfully with a valid page' do
    allow(AppilixNotifications).to receive(:appilix_get_registered_user)
      .with(app_key, api_key, 1).and_return({ 'tokens' => ['token1', 'token2'] })

    response = AppilixNotifications.appilix_get_registered_user(app_key, api_key, 1)

    expect(response).to be_a(Hash)
    expect(response).to have_key('tokens')
    puts response
  end

  it 'raises an error when page is missing for registered user tokens' do
    expect {
      AppilixNotifications.appilix_get_registered_user(app_key, api_key, nil)
    }.to raise_error(ArgumentError, 'Page parameter is mandatory')
  end
end
