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
  'optional_user_identity', # Optional; use "user-1::user-2" for multiple users
  'https://example.com',    # Optional
  notification_image: 'https://example.com/banner.png', # Optional; Android only
  secondary_app_key: 'your_ios_app_key',                # Optional
  secondary_api_key: 'your_ios_api_key'                 # Optional
)

puts response
```
#### Parameters for Sending Notifications

- `app_key` (String): Your application's key from Appilix.
- `api_key` (String): Your API key from Appilix.
- `title` (String): The title of the notification.
- `body` (String): The body content of the notification.
- `user_identity` (String, optional): The user identifier for the notification.
- `open_link_url` (String, optional): A URL to open when the notification is clicked.
- `notification_image` (String, optional keyword): A public image URL (Android only).
- `secondary_app_key` (String, optional keyword): The app key for a second app, such as iOS.
- `secondary_api_key` (String, optional keyword): The API key for the second app.

Notifications are submitted as a `POST` form request to the current Appilix push notification endpoint.


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


### Fetching Registered User Tokens

To fetch registered user tokens, use the `appilix_get_registered_user` method:

```ruby
require 'appilix_notifications'

response = AppilixNotifications.appilix_get_registered_user(
  'your_app_key',
  'your_api_key',
  1, # Optional page number; defaults to 1
  user_identity: 'optional_user_identity',
  items_per_page: 50,
  secondary_app_key: 'your_ios_app_key',
  secondary_api_key: 'your_ios_api_key'
)

puts response
```

#### Parameters for Fetching Registered User Tokens

- `app_key` (String): Your application's key from Appilix.
- `api_key` (String): Your API key from Appilix.
- `page` (Integer, optional): The page number, defaulting to `1`.
- `user_identity` (String, optional keyword): Return tokens for a specific user.
- `items_per_page` (Integer, optional keyword): Results per page, defaulting to `100`.
- `secondary_app_key` (String, optional keyword): The app key for a second app.
- `secondary_api_key` (String, optional keyword): The API key for the second app.


On success, the method returns a parsed JSON response containing the tokens:

```json
{
  "status": true,
  "current_page": 1,
  "has_next_page": false,
  "tokens": [
    {
      "token": "fcm-device-token-string",
      "user_identity": "user@example.com",
      "modified_at": "2026-05-22 10:30:00"
    }
  ]
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
