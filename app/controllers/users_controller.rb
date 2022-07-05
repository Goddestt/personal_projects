class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

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
  rescue StandardError => e
    @errors = e
    @users = User.all
    flash.now[:alert] = 'This user was not found'
    render 'index'
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      flash.now[:errors] = 'This is an error'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to users_path if @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :name, :phone_number, :images, :avatar, :address)
  end
end
