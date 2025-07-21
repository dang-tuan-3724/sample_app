class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # activate the user
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      login user
      flash[:success] = "Account has activated, congratulations!"
      redirect_to user
    else
      # handle invalid link
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
