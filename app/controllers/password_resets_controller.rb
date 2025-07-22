class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]


  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render "new", status: :unprocessable_entity
    end
  end
  def edit; end
  def update
    if @user
      if @user.password_reset_expired?
        flash.now[:danger] = "Password reset has expired."
        redirect_to new_password_reset_path
      elsif params[:user][:password].blank? &&
              params[:user][:password_confirmation].blank?
        flash.now[:danger] = "Password cannot be empty."
        render "edit"
      elsif @user.update(user_params)
        flash[:success] = "Password has been reset."
        redirect_to login_path
      else
        flash.now[:danger] = "Password reset failed."
        render "edit"
      end
    else
      flash.now[:danger] = "Invalid email address."
      render "edit"
    end
  end

  private

  def get_user
    email = params[:user]&.dig(:email) || params[:email]

    # Rails
    #   .logger.info "Email fetched from: #{params[:user]&.dig(:email) ? 'params[:user][:email]' : 'params[:email]'}"
    @user = User.find_by(email: email&.downcase)
    if !@user || !@user.authenticated?(:reset, params[:id]) || @user.activated?
      flash[:danger] = "Invalid password reset link."
      redirect_to root_url
    end
  end
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
