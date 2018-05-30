class Admin::LabelsController < ApplicationController
  layout 'admin_users'
  before_action :admin_user?

  def index
    @labels = TaskLabel.joins(:label).group("labels.name").count.sort_by(&:last).reverse
    @label_ids = []
    @labels.each do |label|
      @label_ids.push(Label.select("id").find_by(name: label[0]))
    end
    @user = User.find(session[:user_id])
  end

  def destroy
    label = find_label_by_id
    label.destroy
    redirect_to admin_labels_path
  end
end

private
def find_label_by_id
  Label.find(params[:id])
end
