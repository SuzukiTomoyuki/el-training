require 'kconv'

class UsersController < ApplicationController
  layout "users"
  # skip_before_action :user_logged_in?, only: [new, create]

  def new
    @group = Group.new
    @user = User.new
    render :layout => 'new_user'
  end

  def show
    @user = find_user_by_id
    task = Task.all.where(user_id: current_user.id)
    @tasks_to_do = task.status_to_do
    @tasks_doing = task.status_doing
    @tasks_done = task.status_done
    @group = Group.new
    @groups = Group.all
  end

  def edit
    @group = Group.new
    @user = find_user_by_id
    if session[:user_id] != @user.id
      render partial: 'errors/forbidden'
    end
  end

  def update
    @user = find_user_by_id
    image_name = create_params[:image]
    if image_name.present?
      image = image_name.original_filename
      @user.image_name = image_name.original_filename
      uploadimg(image_name, image)
    end
    if @user.update(create_params)
      pp params[:image]
      flash[:notice] = "ユーザ情報を更新"
      redirect_to my_tasks_path
    else
      render json: { messages: @user.errors.full_messages }, status: :bad_request
    end
  end

  def create
    @user = User.new(create_params)
    if @user.save
      flash[:success] = "新しいユーザを登録しました"
      redirect_to login_path
    else
      render "new"
    end
  end

  def check_oko
    @user = User.find(params[:id])
    # render 'users/check_oko', formats: 'json', handlers: 'jbuilder'
  end

  def done_osekkyo
    user = User.find(params[:id])
    user.oko = false
    user.save
    redirect_to my_tasks_path
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :image)
  end

  def find_user_by_id
    User.find(params[:id])
  end

  def uploadimg(img_object,image_name)
    ext = image_name[image_name.rindex('.') + 1, 4].downcase
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    if !perms.include?(File.extname(image_name).downcase)
      result = 'アップロードできるのは画像ファイルのみです。'
    elsif img_object.size > 4.megabyte
      result = 'ファイルサイズは4MBまでです。'
    else
      path = "public/assets/images/users/#{params[:id]}/"
      FileUtils.mkdir_p(path) unless FileTest.exist?(path)
      File.open(path + "#{image_name.toutf8}", 'wb') { |f| f.write(img_object.read) }
      result = "success"
    end
    return result
  end

end
