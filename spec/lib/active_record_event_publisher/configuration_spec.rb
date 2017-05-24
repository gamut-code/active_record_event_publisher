require 'rails_helper'

describe ActiveRecordEventPublisher::Configuration do
  subject(:configuration) { described_class.new }

  it { should respond_to(:log) }
  it { should respond_to(:log?) }
  it { should respond_to(:enabled) }
  it { should respond_to(:enabled?) }
  it { should respond_to(:queue_url) }
  it { should respond_to(:aws_region) }
  it { should respond_to(:aws_access_key_id) }
  it { should respond_to(:aws_secret_access_key) }

  describe '#aws_region' do
    it 'raises an error if not set' do
      expect { configuration.aws_region }.to raise_error(ArgumentError)
    end
  end

  describe '#aws_access_key_id' do
    it 'raises an error if not set' do
      expect { configuration.aws_access_key_id }.to raise_error(ArgumentError)
    end
  end

  describe '#aws_secret_access_key' do
    it 'raises an error if not set' do
      expect { configuration.aws_secret_access_key }.to raise_error(ArgumentError)
    end
  end
end
