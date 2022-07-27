class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  before_action :check_staff, except: :information

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      flash.now[:errors] = "This is an error"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to users_path if @user.destroy
  end

  def information
    @user = current_user
    render :show
  end

  private

  def check_staff
    if session[:user_type] == "User"
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :name, :phone_number, :avatar, :addresses_attributes, :email)
  end
end
