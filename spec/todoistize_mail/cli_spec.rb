require 'spec_helper'

describe TodoistizeMail::Cli do
  describe '#sort_task' do
    context 'sort by due_date' do
      let(:task1) { double('task1', due_date: Date.new(2014, 04, 03).strftime, priority: nil) }
      let(:task2) { double('task2', due_date: Date.new(2014, 04, 02).strftime, priority: nil) }
      let(:task3) { double('task3', due_date: Date.new(2014, 04, 01).strftime, priority: nil) }
      let(:tasks) { [task1, task2, task3] }
      let(:options) { { apikey: 'test_apikey', sort: 'date' } }

      subject { described_class.new([], options).sort_task(tasks) }
      its(:count) { should eq 3 }
      it { expect(subject.first).to be task3 }
      it { expect(subject[1]).to be task2 }
      it { expect(subject.last).to be task1 }
    end

    context 'sort by priority' do
      let(:task1) { double('task1', due_date: nil, priority: 3) }
      let(:task2) { double('task2', due_date: nil, priority: 2) }
      let(:task3) { double('task3', due_date: nil, priority: 1) }
      let(:tasks) { [task1, task2, task3] }
      let(:options) { { apikey: 'test_apikey', sort: 'pri' } }

      subject { described_class.new([], options).sort_task(tasks) }
      its(:count) { should eq 3 }
      it { expect(subject.first).to be task3 }
      it { expect(subject[1]).to be task2 }
      it { expect(subject.last).to be task1 }
    end

    context 'sort by multi prameter' do
      context 'first key: pri, second key: date' do
        let(:task1) { double('task1', due_date: Date.new(2014, 04, 02).strftime, priority: 3) }
        let(:task2) { double('task2', due_date: Date.new(2014, 04, 01).strftime, priority: 3) }
        let(:task3) { double('task3', due_date: nil, priority: 1) }
        let(:tasks) { [task1, task2, task3] }
        let(:options) { { apikey: 'test_apikey', sort: 'pri,date' } }

        subject { described_class.new([], options).sort_task(tasks) }
        its(:count) { should eq 3 }
        it { expect(subject.first).to be task3 }
        it { expect(subject[1]).to be task2 }
        it { expect(subject.last).to be task1 }
      end
    end
  end
end
