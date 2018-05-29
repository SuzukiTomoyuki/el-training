require 'rails_helper'

RSpec.describe Admin::TasksController, type: :controller do

  describe "GET #details_task" do
    it "returns http success" do
      get :details_task
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
