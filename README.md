ActiveRecordEventPublisher
==========================

Publish all create, update, and destroy events to an SQS queue.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_record_event_publisher', :git => 'https://github.com/gamut-code/active_record_event_publisher'
```

## Setup

This gem uses environment variables for configuration. Be sure the following `ENV` are set in your app:

```
AWS_REGION=us-east-1
ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE
ACTIVE_RECORD_EVENT_PUBLISHER_LOGGER_ENABLED=true (optional)
```

With the environment variables set, simply add the initializer below to your app:

**config/initializers/active_record_event_publisher.rb**

```ruby
ActiveRecordEventPublisher.setup
```

Restart your app, and all events will be published to SQS.

## Bugs & Feature Requests
Please add an issue in [Github](https://github.com/gamut-code/active_record_event_publisher/issues) if you discover a bug or have a feature request.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
