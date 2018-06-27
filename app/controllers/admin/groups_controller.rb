class Admin::GroupsController < ApplicationController
  layout 'admin_users'
  before_action :admin_user?

  def index
    @group = Group.new
    @groups = Group.all
    @user = current_user
  end

  def update
    @group = find_group_by_id
    @user = current_user
    if @group.update(create_params)
      flash[:notice] = "グループ情報を編集"
    else
      render json: { messages: @group.error.full_messages }, status: :bad_request
    end
  end

  def destroy
    group = find_group_by_id
    group.destroy
    redirect_to admin_groups_path
  end

  private
  def find_group_by_id
    Group.find(params[:id])
  end

  def create_params
    params.require(:group).permit(:id, :name, user_ids: [], task_ids: [])
  end
end
