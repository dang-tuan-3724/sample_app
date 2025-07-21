class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email:params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      # log in and redirect to user's show page
        flash[:success] = 'Logged in successfully'
        login user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. Check your email for the activation link. "
        flash[:warning] = message
        redirect_to root_url
      end

    else
      # create an error message
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end
  def destroy
    logout if loggedin?
    flash[:success] = 'Logged out successfully'
    redirect_to root_path, status: :see_other
  end
end
