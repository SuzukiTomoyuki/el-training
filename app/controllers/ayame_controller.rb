class AyameController < ApplicationController
  def index
    @user = current_user
    pp @user
  end
end
