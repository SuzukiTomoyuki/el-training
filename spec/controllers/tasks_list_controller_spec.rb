# require 'rails_helper'
#
# describe TasksListController, type: :controller do
#
#   describe "GET #edit" do
#     before do
#       @task = FactoryGirl.create(:task, deadline: Date.today)
#     end
#     it "すでにあるタスクを編集する" do
#       expect{
#         get :edit, params: { id: @task.id }
#       }.to change(Task, :count).by(0)   # 助けて
#     end
#   end
#
#   describe "DELETE #delete" do
#     before do
#       @task = FactoryGirl.create(:task, deadline: Date.today)
#     end
#     it "タスクが一つ消える" do
#       expect{
#         delete :destroy, params: { id: @task.id }
#       }.to change(Task, :count).by(-1)
#     end
#   end
# end
