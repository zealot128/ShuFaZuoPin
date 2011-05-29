module ApplicationHelper
  def title(string)
    content_for(:title, string)
  end

  def set_tasks(&block)
    require "local_tasks"
    task_provider = LocalTask.new
    block.call(task_provider)
    tasks = task_provider.tasks
    tasks.map!{|task|
      if task == :seperator
        content_tag :li,"", :class => "seperator"
      else
        content_tag :li, task.html_safe
      end
    }
    content_for :tasks,  tasks.join.html_safe
    nil
  end

  def render_tasks(tasks)
    if tasks.present?
      list = content_tag :ul, tasks, :id => "task-bar"
      contr = content_tag :span, t("controller.#{controller.controller_name}").html_safe , :id => "task-controller"
      contr + list
    else
      ""
    end
  end

end
