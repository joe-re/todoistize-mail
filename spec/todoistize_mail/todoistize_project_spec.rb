require 'spec_helper'

describe TodoistizeMail::TodoistizeProject do
  let(:apikey) { 'test_apikey' }
  let(:test_project_name) { 'test_peoject' }

  before do
    expect(Todoist::Base).to receive(:setup).with(apikey, true)
    expect(Todoist::Project).to receive(:all).and_return([project])
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
    before { expect(Todoist::Task).to receive(:create).with(content, project).and_return('ok') }
    subject { described_class.new(apikey, test_project_name).create_task(content) }
    it { should eq 'ok' }
  end

  describe '#exist?' do
    let(:project) { double('test_peoject', name: test_project_name,  tasks: tasks)  }

    context 'already exist' do
      let(:content) { 'content' }
      let(:tasks) { [double('test_task1', content: content)] }
      subject { described_class.new(apikey, test_project_name).exist?(content) }
      it { should eq true }
    end

    context 'not exist' do
      let(:content) { 'none_content' }
      let(:tasks) { [double('test_task1', content: 'content')] }
      subject { described_class.new(apikey, test_project_name).exist?(content) }
      it { should eq false }
    end
  end
end
