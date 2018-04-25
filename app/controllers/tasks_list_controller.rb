class TasksListController < ApplicationController
  def index
    @task_list = Task.all
  end

  def new
    @task = Task.new
    render action: :new
    # @task.update_time = Date.today
    # @task.save
    # render action: :new
    # respond_to do |format|
    #   if @task.save
    #     format.html { redirect_to @task, notice: 'task was successfully created.' }
    #     format.json { render :show, status: :created, location: @task }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @task.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def create
    # Task.create(create_params)
    @task = Task.new(create_params)
    if @task.save
      redirect_to tasks_list_index_path
    else
      render new_tasks_list_path
    end
    # render action: :new
    # respond_to do |format|
    #   if @task.save
    #     format.html { redirect_to @task, notice: 'task was successfully created.' }
    #     format.json { render :show, status: :created, location: @task }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @task.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
  def create_params
    params.require(:task).permit(:caption, :priority, :deadline, :state, :label)
  end

end
