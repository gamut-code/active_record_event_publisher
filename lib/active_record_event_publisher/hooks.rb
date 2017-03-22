module ActiveRecordEventPublisher
  class Hooks
    def after_create(subject)
      ActiveRecordEventPublishJob.perform_async('create', subject)
    end

    def after_update(subject)
      ActiveRecordEventPublishJob.perform_async('update', subject)
    end

    def after_destroy(subject)
      ActiveRecordEventPublishJob.perform_async('destroy', subject)
    end
  end
end
