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

## Publish Format

The following attributes are published on each data change event:

* `action` - One of the follow options, `create`, `update`, or `destroy`
* `subject_id` - The primary key of the object affected by the change
* `subject_class` - The class name of the object affected by the change
* `subject` - All attributes of the object affected by the change
* `changes` - Only the attributes affected by the change, including their before and after state
* `created_at` - The date, time and zone of when the event happened in ISO 8601 format.

```json
{
  "action": "(create|update|destroy)",
  "subject_id": "(objectId)",
  "subject_class": "(objectClass)",
  "subject": {
    "(objectAttribute1Key)": "(objectAttribute1Value)",
    "(objectAttribute2Key)": "(objectAttribute2Value)",
  },
  "changes": {
    "(changedAttribute1)": [
      "(changedAttribute1Before)",
      "(changedAttribute1After)"
    ],
    "(changedAttribute2)": [
      "(changedAttribute2Before)",
      "(changedAttribute2After)"
    ]
  },
  "created_at": "(timestamp)"
}
```

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
