class LocalTask
  attr_accessor :tasks
  include ActionView::Helpers::UrlHelper
  def initialize
    @tasks = []
  end

  def add_task(title, options)
    active = options.delete(:active) || false
    url   = options.delete(:url)
    active_class = active ? " active" : ""

    options = {:class => "task#{active_class}"}.merge options
    task = link_to title, url, options
    @tasks << task
  end

  def seperator
    @tasks << :seperator

  end


  def self.set_tasks(&block)
    t = LocalTask.new
    block.call(t)
    t.tasks
  end
end
