# frozen_string_literal: true

require_relative "appilix_notifications/version"

require "net/http"
require "uri"
require "json"

module AppilixNotifications
  BASE_URL = "https://appilix.com/api"
  PUSH_NOTIFICATION_URL = "push-notification"
  TOKEN_LIST_URL = "push-notification-token"

  module_function

  def appilix_send_notifications(app_key, api_key, title, body, user_identity = nil, open_link_url = nil,
    notification_image: nil, secondary_app_key: nil, secondary_api_key: nil)
    uri = URI("#{BASE_URL}/#{PUSH_NOTIFICATION_URL}")
    form_data = compact_parameters(
      "app_key" => app_key,
      "api_key" => api_key,
      "notification_title" => title,
      "notification_body" => body,
      "user_identity" => user_identity,
      "open_link_url" => open_link_url,
      "notification_image" => notification_image,
      "secondary_app_key" => secondary_app_key,
      "secondary_api_key" => secondary_api_key
    )

    request = Net::HTTP::Post.new(uri)
    request.set_form_data(form_data)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    handle_response(response)
  end

  def appilix_get_registered_user(app_key, api_key, page = 1, user_identity: nil, items_per_page: 100,
    secondary_app_key: nil, secondary_api_key: nil)
    uri = URI("#{BASE_URL}/#{TOKEN_LIST_URL}")
    uri.query = URI.encode_www_form(compact_parameters(
      "app_key" => app_key,
      "api_key" => api_key,
      "page" => page,
      "items_per_page" => items_per_page,
      "user_identity" => user_identity,
      "secondary_app_key" => secondary_app_key,
      "secondary_api_key" => secondary_api_key
    ))

    request = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    handle_response(response)
  end

  def handle_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      {"error" => response.message, "code" => response.code, "body" => parse_body_safe(response.body)}
    end
  rescue JSON::ParserError
    {"error" => "Invalid JSON response", "body" => response.body}
  end

  def parse_body_safe(body)
    JSON.parse(body)
  rescue JSON::ParserError
    body
  end

  def compact_parameters(parameters)
    parameters.reject { |_key, value| value.nil? }
  end
end
