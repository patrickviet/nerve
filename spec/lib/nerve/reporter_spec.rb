require 'spec_helper'

describe Nerve::Reporter do
  let(:subject) { {
      'zk_hosts' => ['zkhost1', 'zkhost2'],
      'zk_path' => 'zk_path',
      'instance_id' => 'instance_id',
      'host' => 'host',
      'port' => 'port'
    }
  }
  it 'can new_from_service' do
    expect(Nerve::Reporter::Zookeeper).to receive(:new).with(subject).and_return('kerplunk')
    expect(Nerve::Reporter.new_from_service(subject)).to eq('kerplunk')
  end
  it 'actually constructs an instance of a specific backend' do
    expect(Nerve::Reporter.new_from_service(subject).is_a?(Nerve::Reporter::Zookeeper)).to eql(true)
  end
  it 'the reporter backend inherits from the base class' do
    expect(Nerve::Reporter.new_from_service(subject).is_a?(Nerve::Reporter::Base)).to eql(true)
  end
  it 'throws ArgumentError if you ask for a reporter type which does not exist' do
    subject['reporter_type'] = 'does_not_exist'
    expect { Nerve::Reporter.new_from_service(subject) }.to raise_error(ArgumentError)
  end
end

