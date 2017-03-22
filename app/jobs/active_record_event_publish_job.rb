class ActiveRecordEventPublishJob
  include SuckerPunch::Job

  def perform(action, subject)
    ActiveRecordEventPublisher::EventBuilder.new(action, subject).publish
  end
end
