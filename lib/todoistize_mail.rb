require 'todoist'
require 'todoistize_mail/version'
require 'todoistize_mail/cli'
require 'todoistize_mail/mailer'
require 'todoistize_mail/todoistize_project'

module TodoistizeMail
  include Todoist
  YAML_PATH = "#{Dir.home}/.todoistize.yml"
end
