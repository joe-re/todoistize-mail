require 'net/imap'
require 'kconv'
require 'highline'

module TodoistizeMail
  class Mailer

    MAILBOX_NAME = 'INBOX'
    SUBJECT_ATTR = 'BODY[HEADER.FIELDS (SUBJECT)]'
    def initialize(host, port, usessl)
      @imap = Net::IMAP.new(host, port, usessl)
    end

    def login(user, passwd)
      @imap.login(user, passwd)
      if block_given?
        yield self
        logout
      end
      self
    end

    def logout
      @imap.logout
      self
    end

    def unread_subjects
      unread_list.each_with_object([]) { |(_id, subject), subjects| subjects << subject }
    end

    def unread?(subject)
      unread_list.each { |_id, unread_subject| return true if subject =~ /^#{unread_subject}$/ }
      false
    end

    def mark_read(subject)
      target = unread_list.select { |_k, unread_subject| subject =~ /^#{unread_subject}$/ }
      return if target.count == 0
      yield target if block_given?
      @imap.select(MAILBOX_NAME)
      target.each { |id, _v| @imap.store(id, '+FLAGS', [:Seen]) }
    end

    private

    def unread_list
      @imap.examine(MAILBOX_NAME)
      @imap.search(['UNSEEN']).each_with_object({}) do |id, hash|
        msg = @imap.fetch(id, [SUBJECT_ATTR]).first
        hash.merge!(id => msg.attr[SUBJECT_ATTR].toutf8.strip)
      end
    end
  end
end
