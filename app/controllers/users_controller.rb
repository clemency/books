class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.identity_url = session[:identity_url]
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/messages')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

end
