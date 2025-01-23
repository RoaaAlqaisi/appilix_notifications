# frozen_string_literal: true

require_relative "appilix_notifications/version"

require 'net/http'
require 'uri'
require 'json'

module AppilixNotifications
  BASE_URL = "https://appilix.com/api"
  PUSH_NOTIFICATION_URL = "push-notification"
  TOKEN_LIST_URL = "push_notification_token_list.php"

  module_function

  def appilix_send_notifications(app_key, api_key, title, body, user_identity = nil, open_link_url = nil)
    uri = URI("#{BASE_URL}/#{PUSH_NOTIFICATION_URL}")
    uri.query = URI.encode_www_form(
      'app_key' => app_key,
      'api_key' => api_key,
      'notification_title' => title,
      'notification_body' => body,
      'user_identity' => user_identity,
      'open_link_url' => open_link_url
    )

    request = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    handle_response(response)
  end

  def appilix_registered_user_tokens(app_key, api_key, page)
    raise ArgumentError, "Page parameter is mandatory" unless page

    uri = URI("#{BASE_URL}/#{TOKEN_LIST_URL}")
    uri.query = URI.encode_www_form(
      'app_key' => app_key,
      'api_key' => api_key,
      'page' => page
    )

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
      { 'error' => response.message, 'code' => response.code, 'body' => parse_body_safe(response.body) }
    end
  rescue JSON::ParserError
    { 'error' => 'Invalid JSON response', 'body' => response.body }
  end

  def parse_body_safe(body)
    JSON.parse(body)
  rescue JSON::ParserError
    body
  end
end
