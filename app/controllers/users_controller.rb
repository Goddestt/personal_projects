class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  rescue StandardError => e
    @errors = e
    @users = User.all
    flash.now[:alert] = 'This user was not found'
    render 'index'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :phone_number, :images, :avatar))
      redirect_to edit_user_path(@user)
    else
      flash.now[:errors] = 'This is an error'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to :show if @user.destroy
  end
end
