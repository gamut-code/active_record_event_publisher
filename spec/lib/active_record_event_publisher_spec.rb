require 'rails_helper'

describe ActiveRecordEventPublisher do
  def configure(enabled, queue_url='http://example.com')
    described_class.configure do |config|
      config.aws_region = 'us-east-1'
      config.aws_secret_access_key = 'secret_key'
      config.aws_access_key_id = 'key_id'
      config.queue_url = queue_url
      config.enabled = enabled
      config.log = true
    end
  end

  describe '.configure' do
    it 'configures the publisher if enabled' do
      expect(Rails).to receive_message_chain(:logger, :info)
        .with('ActiveRecordEventPublisher enabled.')
      expect(Wisper::ActiveRecord).to receive(:extend_all).and_call_original

      configure(true)
    end

    it 'does not configure the publisher if not enabled' do
      expect(Rails).to receive_message_chain(:logger, :info)
        .with('ActiveRecordEventPublisher disabled.')
      expect(Wisper::ActiveRecord).not_to receive(:extend_all)

      configure(false)
    end

    it 'raises an error if enabled and queue url is blank' do
      expect {
        configure(true, '')
      }.to raise_error(ArgumentError).with_message('Set enabled to false rather than passing an empty queue url')
    end
  end

  describe '.configuration' do
    it 'returns an instance of ActiveRecordEventPublisher::Configuration' do
      expect(described_class.configuration).to be_kind_of(ActiveRecordEventPublisher::Configuration)
    end
  end
end
