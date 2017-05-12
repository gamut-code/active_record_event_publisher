module ActiveRecordEventPublisher
  class EventBuilder
    def initialize(action, subject)
      @action   = action
      @subject  = subject
    end

    def publish
      return unless ENV['ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE'].present?
      queue = Aws::SQS::Queue.new(ENV['ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE'])
      data = event_data.to_json
      queue.send_message(:message_body => data)

      return unless ENV['ACTIVE_RECORD_EVENT_PUBLISHER_LOGGER_ENABLED'] == 'true'
      Rails.logger.info("Active Record Event Publisher Event Data: #{data}")
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
  end
end
