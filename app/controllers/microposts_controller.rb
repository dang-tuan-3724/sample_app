class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy ]
  before_action :correct_user,   only: :destroy
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:my_img])
    if @micropost.save
      flash[:success] = "Micropost was created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      render "static_pages/home"
    end
  end
  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.user == current_user
      @micropost.destroy
      flash[:success] = "Micropost deleted"
    else
      flash[:danger] = "You can only delete your own microposts"
    end
    redirect_to root_url || requesr.referrer
  end
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
