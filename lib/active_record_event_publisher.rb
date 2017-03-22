require 'aws-sdk'
require 'active_record_event_publisher/engine'
require 'active_record_event_publisher/event_builder'
require 'active_record_event_publisher/hooks'
require 'sucker_punch'
require 'wisper'
require 'wisper/active_record'

module ActiveRecordEventPublisher
  def self.setup
    if ENV['ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE']
      Wisper::ActiveRecord.extend_all
      ApplicationRecord.subscribe(Hooks.new)
      Rails.logger.info('ActiveRecordEventPublisher enabled.')
    else
      Rails.logger.warn('ActiveRecordEventPublisher not configured, disabling.')
    end
  end
end
