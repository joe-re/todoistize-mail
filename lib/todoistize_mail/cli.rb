require 'thor'
require 'date'
module TodoistizeMail
  class Cli < Thor
    def self.option_todoist_authentication
      method_option :apikey, type: :string, aliases: '-k', default: ENV['tize_apikey'], required: true, desc: 'your todoist apikey'
    end

    desc 'tasks', 'show your uncompleted tasks'
    option option_todoist_authentication
    def tasks
      Todoist::Base.setup(@options[:apikey], true)
      Todoist::Project.all.each do |p|
        puts "-- Project: #{p.name} --"
        puts 'Completed!' if p.tasks.count == 0
        p.tasks.each { |task| print_task task }
        puts ''
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
