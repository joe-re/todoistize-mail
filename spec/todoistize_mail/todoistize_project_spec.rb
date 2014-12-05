require 'spec_helper'

describe TodoistizeMail::TodoistizeProject do
  let(:apikey) { 'test_apikey' }
  let(:test_project_name) { 'test_peoject' }

  before do
    expect(Base).to receive(:setup).with(apikey, false)
    expect(Project).to receive(:all).and_return([project])
  end

  describe '#uncomplete_tasks' do
    let(:tasks) { %w('test_task1', 'test_task2') }
    let(:project) { double('test_peoject', name: test_project_name, tasks: tasks)  }
    subject { described_class.new(apikey, test_project_name).uncomplete_tasks }
    it { should be tasks }
  end

  describe '#create_task' do
    let(:content) { 'content' }
    let(:project) { double('test_peoject', name: test_project_name)  }
    before { expect(Task).to receive(:create).with(content, project).and_return('ok') }
    subject { described_class.new(apikey, test_project_name).create_task(content) }
    it { should eq 'ok' }
  end
end
