module TodoistizeMail
  class TodoistizeProject
    def initialize(apikey, project_name)
      Todoist::Base.setup(apikey, true)
      project = Todoist::Project.all.select { |p| p.name =~ /^#{project_name}$/ }
      project = [Todoist::Base.get('/addProject', query: { name: project_name })] if project.count <= 0
      @project = project.first
    end

    def uncomplete_tasks
      @project.tasks
    end

    def create_task(content)
      Todoist::Task.create(content, @project)
    end

    def exist?(content)
      uncomplete_tasks.each { |task| return true if task.content =~ /^#{content}$/ }
      false
    end

    def todoistize?(task)
      uncomplete_tasks.each { |t| return true if task.id == t.id }
      false
    end
  end
end
