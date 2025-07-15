class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email:params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # log in and redirect to user's show page
      flash[:success] = 'Logged in successfully'
      login user
      redirect_to user
    else
      # create an error message
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end
  def destroy
    render 'new'
  end
end
