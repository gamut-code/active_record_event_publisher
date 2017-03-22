require 'rails_helper'

describe ActiveRecordEventPublisher::Hooks do
  describe '#after_create' do
    it 'calls the event builder when invoked' do
      user = User.new(name: 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('create', user)
      subject.after_create(user)
    end
  end

  describe '#after_update' do
    it 'calls the event builder when invoked' do
      user = User.new(name: 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('update', user)
      subject.after_update(user)
    end
  end

  describe '#after_destroy' do
    it 'calls the event builder when invoked' do
      user = User.new(name: 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('destroy', user)
      subject.after_destroy(user)
    end
  end
end
