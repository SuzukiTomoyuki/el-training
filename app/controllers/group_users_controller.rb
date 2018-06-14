class GroupUsersController < ApplicationController
  def update
    @group_user = GroupUser.find_or_create_by(group_id: params[:group_id], user_id: params[:id])
    flash[:notice] = "メンバーを追加しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @group_user = GroupUser.find_by(group_id: params[:group_id], user_id: params[:id])
    if @group_user.destroy
      flash[:notice] = "グループから削除しました"
      redirect_back(fallback_location: root_path)
    end
  end
end
