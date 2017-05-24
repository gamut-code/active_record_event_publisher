require 'aws-sdk'
require 'active_record_event_publisher/configuration'
require 'active_record_event_publisher/engine'
require 'active_record_event_publisher/event_builder'
require 'active_record_event_publisher/hooks'
require 'sucker_punch'
require 'wisper'
require 'wisper/active_record'

module ActiveRecordEventPublisher
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)

    if configuration.enabled?
      queue_url = configuration.queue_url
      raise ArgumentError, "Set enabled to false rather than passing an empty queue url" if queue_url.blank?

      Wisper::ActiveRecord.extend_all
      ApplicationRecord.subscribe(Hooks.new)
      Rails.logger.info('ActiveRecordEventPublisher enabled.')
    else
      Rails.logger.info('ActiveRecordEventPublisher disabled.')
    end
  end
end
