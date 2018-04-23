class TasksListController < ApplicationController
  def index
    @task_list = Task.all
  end
end
