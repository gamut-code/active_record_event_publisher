module ActiveRecordEventPublisher
  class Configuration
    attr_accessor :aws_region, :aws_secret_access_key, :aws_access_key_id,
      :log, :enabled, :queue_url

    alias_method :enabled?, :enabled
    alias_method :log?, :log

    def log
      @log || false
    end

    def aws_region
      @aws_region || raise(ArgumentError, "#{self.class} aws_region required")
    end

    def aws_access_key_id
      @aws_access_key_id || raise(ArgumentError, "#{self.class} aws_secret_key required")
    end

    def aws_secret_access_key
      @aws_secret_access_key || raise(ArgumentError, "#{self.class} aws_access_key required")
    end
  end
end
