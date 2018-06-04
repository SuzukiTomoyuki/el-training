class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    if @group.save

    end
  end

  def update
    @user = find_group_by_id
  end

  def show
    @group = Group.find(params[:id])
  end

  private
  def find_group_by_id
    Group.find(params[:id])
  end

  def create_params
    params.require(:group).permit(:id, :name, user_ids: [])
  end
end
