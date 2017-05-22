require 'rails_helper'

describe ActiveRecordEventPublisher::EventBuilder do
  before do
    stub_const('ENV',
               'ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE' => 'NOT_REAL',
               'AWS_REGION' => 'NOT_REAL')
  end

  describe '#publish' do
    it 'published the event to the SQS queue' do
      Timecop.freeze
      user = User.create(:name => 'foo')

      event = described_class.new('create', user)
      expect_any_instance_of(Aws::SQS::Queue).to receive(:send_message)
        .with(:message_body => event.event_data.to_json)
      event.publish
      Timecop.return
    end

    it 'writes a log line when the env variable is enabled' do
      stub_const('ENV',
                 'ACTIVE_RECORD_EVENT_PUBLISHER_LOGGER_ENABLED' => 'true',
                 'ACTIVE_RECORD_EVENT_PUBLISHER_QUEUE' => 'NOT_REAL',
                 'AWS_REGION' => 'NOT_REAL')

      Timecop.freeze
      user = User.create(:name => 'foo')

      event     = described_class.new('create', user)
      json_data = event.event_data.to_json

      expect_any_instance_of(Aws::SQS::Queue).to receive(:send_message)
        .with(:message_body => json_data)

      expect(Rails).to receive_message_chain(:logger, :info)
        .with("Active Record Event Publisher Event Data: #{json_data}")

      event.publish
      Timecop.return
    end
  end

  describe '#event_data' do
    it 'returns the correct reponse for a create event' do
      user = User.create(:name => 'foo')

      event = described_class.new('create', user)
      data = event.event_data

      expect(data[:action]).to eq('create')
      expect(data[:subject_id]).to eq(user.id)
      expect(data[:subject_class]).to eq('User')
      expect(data[:subject].keys).to eq(%w(id name email created_at updated_at))
      expect(data[:changes]['id']).to eq([nil, 1])
      expect(data[:changes]['name']).to eq([nil, 'foo'])
    end

    it 'returns the correct reponse for a update event' do
      user = User.create(:name => 'foo')
      user.reload
      user.update_attributes(:name => 'bar')

      event = described_class.new('update', user)
      data = event.event_data

      expect(data[:action]).to eq('update')
      expect(data[:subject_id]).to eq(user.id)
      expect(data[:subject_class]).to eq('User')
      expect(data[:subject].keys).to eq(%w(id name email created_at updated_at))
      expect(data[:changes]['id']).to eq(nil)
      expect(data[:changes]['name']).to eq(%w(foo bar))
    end

    it 'returns the correct reponse for a destroy event' do
      user = User.create(:name => 'foo')
      user.reload
      user.destroy

      event = described_class.new('destroy', user)
      data = event.event_data

      expect(data[:action]).to eq('destroy')
      expect(data[:subject_id]).to eq(user.id)
      expect(data[:subject_class]).to eq('User')
      expect(data[:subject].keys).to eq(%w(id name email created_at updated_at))
      expect(data[:changes]).to eq({})
    end
  end
end
