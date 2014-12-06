require 'todoist'
include Todoist

module TodoistizeMail
  class TodoistizeProject
    def initialize(apikey, project_name)
      Base.setup(apikey, true)
      project = Project.all.select { |p| p.name =~ /#{project_name}/ }
      return if project.count <= 0 # ToDo: throw error
      @project = project.first
    end

    def uncomplete_tasks
      @project.tasks
    end

    def create_task(content)
      Task.create(content, @project)
    end
  end
end
