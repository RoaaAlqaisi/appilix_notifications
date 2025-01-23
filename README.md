# AppilixNotifications

`AppilixNotifications` is a Ruby gem crafted to streamline the process of sending push notifications and retrieving registered user tokens via the Appilix API. It offers a user-friendly interface to dispatch notifications with customizable parameters such as title, body, user identity, and links, as well as to fetch notification tokens for registered users. This gem leverages the capabilities of Appilix, a platform that enables the transformation of any website into a mobile application without requiring any coding. Developed by Alzahidi-tech, this gem ensures efficient notification management.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'appilix_notifications'
```

Then run:

```sh
bundle install
```

## Usage

### Sending a Notification

To send a notification, use the `appilix_send_notifications` method:

```ruby
require 'appilix_notifications'

response = AppilixNotifications.appilix_send_notifications(
  'your_app_key',
  'your_api_key',
  'Your Notification Title',
  'Your Notification Body',
  'optional_user_identity', # Optional
  'https://example.com'     # Optional
)

puts response
```

### Fetching Registered User Tokens

To fetch registered user tokens, use the `appilix_registered_user_tokens` method. The `page` parameter is mandatory:

```ruby
require 'appilix_notifications'

response = AppilixNotifications.appilix_registered_user_tokens(
  'your_app_key',
  'your_api_key',
  1 # Page number
)

puts response
```

### Parameters for Sending Notifications

- `app_key` (String): Your application's key from Appilix.
- `api_key` (String): Your API key from Appilix.
- `title` (String): The title of the notification.
- `body` (String): The body content of the notification.
- `user_identity` (String, optional): The user identifier for the notification.
- `open_link_url` (String, optional): A URL to open when the notification is clicked.

### Parameters for Fetching Registered User Tokens

- `app_key` (String): Your application's key from Appilix.
- `api_key` (String): Your API key from Appilix.
- `page` (Integer): The page number to fetch tokens from (mandatory).

### Example Responses

#### Sending Notifications

On success, the method returns a parsed JSON response:

```json
{
  "status": "success",
  "message": "Notification sent successfully"
}
```

On failure, the method returns an error hash:

```json
{
  "error": "Invalid API key",
  "code": "401",
  "body": "The provided API key is incorrect."
}
```

If the server response contains invalid JSON, you will receive:

```json
{
  "error": "Invalid JSON response",
  "body": "<Raw response body>"
}
```

#### Fetching Registered User Tokens

On success, the method returns a parsed JSON response containing the tokens:

```json
{
  "tokens": ["token1", "token2", "token3"],
  "status": "true"
}
```

On failure, the method returns an error hash:

```json
{
  "error": "Invalid API key",
  "code": "401",
  "body": "The provided API key is incorrect."
}
```

If the server response contains invalid JSON, you will receive:

```json
{
  "error": "Invalid JSON response",
  "body": "<Raw response body>"
}
```