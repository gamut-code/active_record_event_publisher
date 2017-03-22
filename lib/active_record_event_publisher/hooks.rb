module ActiveRecordEventPublisher
  class Hooks
    def after_create(subject)
      ActiveRecordEventPublisher::EventBuilder.new('create', subject).publish
    end

    def after_update(subject)
      ActiveRecordEventPublisher::EventBuilder.new('update', subject).publish
    end

    def after_destroy(subject)
      ActiveRecordEventPublisher::EventBuilder.new('destroy', subject).publish
    end
  end
end
