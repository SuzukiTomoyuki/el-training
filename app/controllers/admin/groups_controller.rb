class Admin::GroupsController < ApplicationController
  def index
    @group = Group.new
  end

  def new
  end

  def create

  end

  def update
  end

  def destroy
  end

  private
  def find_group_by_id
    Group.find(params[:id])
  end

  def create_params
    params.require(:group).permit(:id, :name, user_ids: [], task_ids: [])
  end
end
