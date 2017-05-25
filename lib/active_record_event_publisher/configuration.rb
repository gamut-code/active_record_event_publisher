module ActiveRecordEventPublisher
  class Configuration
    attr_accessor :log, :enabled, :queue_url

    alias_method :enabled?, :enabled
    alias_method :log?, :log

    def log
      @log || false
    end
  end
end
