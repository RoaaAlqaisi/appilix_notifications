require_relative "../lib/appilix_notifications"

RSpec.describe AppilixNotifications do
  let(:app_key) { "key1" }
  let(:api_key) { "apikey1" }
  let(:http) { instance_double(Net::HTTP) }

  before { allow(Net::HTTP).to receive(:start).and_yield(http) }

  def successful_response(body)
    response = Net::HTTPOK.new("1.1", "200", "OK")
    allow(response).to receive(:body).and_return(JSON.generate(body))
    response
  end

  it "sends a notification using a POST form request" do
    allow(http).to receive(:request).and_return(successful_response("status" => true))

    response = described_class.appilix_send_notifications(
      app_key, api_key, "Hello", "Notification body", "user@example.com", "https://example.com",
      notification_image: "https://example.com/image.png",
      secondary_app_key: "ios-key", secondary_api_key: "ios-api-key"
    )

    expect(response).to eq("status" => true)
    expect(http).to have_received(:request) do |request|
      expect(request).to be_a(Net::HTTP::Post)
      expect(request.uri.to_s).to eq("https://appilix.com/api/push-notification")
      expect(URI.decode_www_form(request.body).to_h).to eq(
        "app_key" => app_key, "api_key" => api_key,
        "notification_title" => "Hello", "notification_body" => "Notification body",
        "user_identity" => "user@example.com", "open_link_url" => "https://example.com",
        "notification_image" => "https://example.com/image.png",
        "secondary_app_key" => "ios-key", "secondary_api_key" => "ios-api-key"
      )
    end
  end

  it "fetches FCM tokens from the current endpoint with documented parameters" do
    body = {"status" => true, "current_page" => 2, "has_next_page" => false, "tokens" => []}
    allow(http).to receive(:request).and_return(successful_response(body))

    response = described_class.appilix_get_registered_user(
      app_key, api_key, 2, user_identity: "user@example.com", items_per_page: 50,
      secondary_app_key: "ios-key", secondary_api_key: "ios-api-key"
    )

    expect(response).to eq(body)
    expect(http).to have_received(:request) do |request|
      expect(request).to be_a(Net::HTTP::Get)
      expect(request.uri.path).to eq("/api/push-notification-token")
      expect(URI.decode_www_form(request.uri.query).to_h).to eq(
        "app_key" => app_key, "api_key" => api_key, "page" => "2", "items_per_page" => "50",
        "user_identity" => "user@example.com", "secondary_app_key" => "ios-key",
        "secondary_api_key" => "ios-api-key"
      )
    end
  end

  it "uses the API pagination defaults when token options are omitted" do
    allow(http).to receive(:request).and_return(successful_response("status" => true, "tokens" => []))

    described_class.appilix_get_registered_user(app_key, api_key)

    expect(http).to have_received(:request) do |request|
      expect(URI.decode_www_form(request.uri.query).to_h).to include("page" => "1", "items_per_page" => "100")
    end
  end
end
