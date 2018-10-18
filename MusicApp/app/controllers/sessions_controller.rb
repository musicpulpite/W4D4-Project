class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params["email"], params["password"])

    if @user
      login!(@user)
      redirect_to bands_url
    else
      flash[:errors] = "Email or Password is incorrect"
      redirect_to user_url
    end
  end

  def destroy
    logout_user!
  end
end
