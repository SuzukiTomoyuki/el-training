class GroupUsersController < ApplicationController
  def show
    @group_user = GroupUser.find_or_create_by(group_id: params[:group_id], user_id: params[:id])
    flash[:notice] = "メンバーを追加しました"
  end

  def destroy
    @group_user = GroupUser.find_by(group_id: params[:group_id], user_id: params[:id])
    if @group_user.destroy
      flash[:notice] = "グループから削除しました"
    end
  end
end
