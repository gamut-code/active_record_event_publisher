module ActiveRecordEventPublisher
  class EventBuilder
    def initialize(action, subject)
      @action = action
      @subject = subject
    end

    def publish
      add_aws_configuration
      queue = Aws::SQS::Queue.new(configuration.queue_url)
      data = event_data.to_json
      queue.send_message(:message_body => data)

      configuration.log? && Rails.logger.info("Active Record Event Publisher Event Data: #{data}")
    end

    def event_data
      {
        :action => @action,
        :subject_id => @subject.id,
        :subject_class => @subject.class.to_s,
        :subject => @subject.attributes,
        :changes => @subject.previous_changes,
        :created_at => Time.now.utc
      }
    end

    private

    def configuration
      ActiveRecordEventPublisher.configuration
    end

    def add_aws_configuration
      Aws.config.update(
        region: configuration.aws_region,
        credentials: Aws::Credentials.new(
          configuration.aws_access_key_id,
          configuration.aws_secret_access_key
        )
      )
    end
  end
end
