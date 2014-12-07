require 'thor'
require 'date'
module TodoistizeMail
  class Cli < Thor
    def self.option_todoist_authentication
      method_option :apikey, type: :string, aliases: '-k', default: ENV['tize_apikey'], desc: 'todoist apikey'
    end

    def self.option_imap_authentication
      method_option :host, type: :string, aliases: '-h', default: ENV['tize_imap_host'], desc: 'imap host'
      method_option :port, type: :numeric, aliases: '-p', default: ENV['tize_imap_port'], desc: 'imap port'
      method_option :ssl, type: :boolean, aliases: '-s', default: ENV['tize_imap_ssl'],  desc: 'use ssl'
      method_option :user, type: :string, aliases: '-u', default: ENV['tize_imap_user'], desc: 'mail user'
      method_option :password, type: :string, aliases: '-P', default: ENV['tize_imap_password'], desc: 'mail password'
    end

    desc 'tasks', 'show your uncompleted tasks'
    option_todoist_authentication
    method_option :sort, type: :string, aliases: '-s', default: 'date,pri', desc: 'date: by due_date, pri: by priority'
    def tasks
      Todoist::Base.setup(@options[:apikey], true)
      Todoist::Project.all.each do |p|
        puts "-- Project: #{p.name} --"
        puts 'Completed!' if p.tasks.count == 0
        sort_task(p.tasks).each { |task| print_task task }
        puts ''
      end
    end

    desc 'unread', 'show your unread mails'
    option_imap_authentication
    def unread
      imap = TodoistizeMail::Mailer.new(@options[:host], @options[:port], @options[:ssl])
      imap.login(@options[:user], @options[:password])
      puts imap.unread_subjects
    end

    no_commands do
      class SortableTask
        attr_accessor :date, :pri, :task
        include Comparable

        def initialize(task)
          @task = task
          @date = task.due_date ? Date.parse(task.due_date) : Date.new(9999, 1, 1)
          @pri = task.priority
        end

        def self.create(tasks)
          tasks.each_with_object([]) { |task, ary| ary << SortableTask.new(task) }
        end
      end

      def sort_task(tasks)
        params = @options[:sort].split(',').select { |param| SortableTask.method_defined?(param) }
        sorted = SortableTask.create(tasks).sort_by do |task|
          params.each_with_object([]) { |param, ary| ary << task.instance_eval(param) }
        end
        sorted.each_with_object([]) { |t, ary| ary << t.task }
      end
    end

    private

    def print_task(task)
      print "pri:#{task.priority}".ljust(7)
      due_date = task.due_date ? Date.parse(task.due_date).strftime : 'none'
      print "date:#{due_date}".ljust(17)
      print "#{task.content}".slice(0..50).ljust(50)
      print "\n"
    end
  end
end
