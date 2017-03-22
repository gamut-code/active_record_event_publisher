require 'rails_helper'

describe ActiveRecordEventPublisher::Hooks do
  subject(:hook) { described_class.new }

  describe '#after_create' do
    it 'calls the event builder when invoked' do
      user = User.new(:name => 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('create', user)
      hook.after_create(user)
    end
  end

  describe '#after_update' do
    it 'calls the event builder when invoked' do
      user = User.new(:name => 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('update', user)
      hook.after_update(user)
    end
  end

  describe '#after_destroy' do
    it 'calls the event builder when invoked' do
      user = User.new(:name => 'foo')
      expect(ActiveRecordEventPublishJob).to receive(:perform_async).with('destroy', user)
      hook.after_destroy(user)
    end
  end
end
