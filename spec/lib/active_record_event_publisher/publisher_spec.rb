require 'rails_helper'

describe ActiveRecordEventPublisher::Publisher do
  before do
    stub_const('ENV',
      {
        'AWS_ACCESS_KEY' => 'NOT_REAL',
        'AWS_SECRET_KEY' => 'NOT_REAL',
        'ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE' => 'http://localhost:4568'
      }
    )

    ActiveRecordEventPublisher.setup
  end

  describe '#event_data' do
    it 'returns the expected response when an object is created' do
      user = User.new(name: 'foo')
      expect_any_instance_of(ActiveRecordEventPublisher::Publisher).to receive(:after_create)
      user.save
    end

    it 'returns the expected response when an object is updated' do
      user = User.create(name: 'foo')
      expect_any_instance_of(ActiveRecordEventPublisher::Publisher).to receive(:after_update)
      user.name='bar'
      user.save
    end

    it 'returns the expected response when an object is deleted' do
      user = User.create(name: 'foo')
      expect_any_instance_of(ActiveRecordEventPublisher::Publisher).to receive(:after_destroy)
      user.destroy
    end
  end
end
