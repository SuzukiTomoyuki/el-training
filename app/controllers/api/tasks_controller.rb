class Api::TasksController < ApplicationController
  def index
    # pp params[:message][:id]
    # task = Task.find(params[:message][:id])
    # task.status = params[:message][:status]
    # task.update(create_params)
  end

  def update
    if params[:task][:id].present? or params[:task][:status].present?
      task = Task.find(params[:task][:id])
      if task.update(create_params)

      end
    end
  end

  private
  def create_params
    params.require(:task).permit(:id, :status)
  end
end
