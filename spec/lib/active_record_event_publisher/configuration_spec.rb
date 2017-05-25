require 'rails_helper'

describe ActiveRecordEventPublisher::Configuration do
  subject(:configuration) { described_class.new }

  it { should respond_to(:log) }
  it { should respond_to(:log?) }
  it { should respond_to(:enabled) }
  it { should respond_to(:enabled?) }
  it { should respond_to(:queue_url) }
end
