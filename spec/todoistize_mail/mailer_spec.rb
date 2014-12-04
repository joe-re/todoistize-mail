require 'spec_helper'

describe TodoistizeMail::Mailer do

  let(:host) { 'test.com' }
  let(:port) { '111' }
  let(:usessl) { true }

  let(:imap) { double('imap') }
  before { expect(Net::IMAP).to receive(:new).with(host, port, usessl).and_return(imap) }

  describe '#login' do
    let(:user) { 'test_user' }
    let(:passwd) { 'passwd' }
    before { expect(imap).to receive(:login).with(user, passwd) }
    subject { described_class.new(host, port, usessl).login(user, passwd) }

    it 'return myself' do
      expect(subject.instance_of?(described_class)).to be true
    end
  end

  describe '#logout' do
    before { expect(imap).to receive(:logout) }
    subject { described_class.new(host, port, usessl).logout }

    it 'return myself' do
      expect(subject.instance_of?(described_class)).to be true
    end
  end
end
