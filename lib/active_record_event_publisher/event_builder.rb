module ActiveRecordEventPublisher
  class EventBuilder
    def initialize(action, subject)
      @action = action
      @subject = subject
    end

    def publish
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
  end
end
