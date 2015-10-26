class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(:email => params[:session][:email].downcase).first
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash.now[:error] = "Invalid email/password combination."
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
