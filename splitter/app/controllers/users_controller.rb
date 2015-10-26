class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successfully signed up'
      login(@user)
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @debts = @user.debts
    @credits = @user.credits
  end

  def logout_user
    logout
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:contact_number)
  end
end
