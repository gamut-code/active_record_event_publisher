require 'rails_helper'

describe ActiveRecordEventPublisher do
  describe '#setup' do
    it 'logs a warning if the configuration is not supplied' do
      expect(Rails).to receive_message_chain(:logger, :warn).with("ActiveRecordEventPublisher not configured, disabling.")
      ActiveRecordEventPublisher.setup
    end

    it 'executes the setup if the confiration is supplied' do
      stub_const('ENV',
        {
          'AWS_ACCESS_KEY' => 'NOT_REAL',
          'AWS_SECRET_KEY' => 'NOT_REAL',
          'ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE' => 'NOT_REAL'
        }
      )

      expect(Rails).to receive_message_chain(:logger, :info).with("ActiveRecordEventPublisher enabled.")
      ActiveRecordEventPublisher.setup
    end
  end
end