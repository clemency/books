# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    options = {
       :return_to => "session/create",
       :realm => "http://localhost:3001",
       :assoc_handle => "1223356514:JRyUMnA5T7iPgDLRyrTC:0154ec1473"
    }
    authenticate_with_open_id  do |result, identity_url|
      if result.successful?
          if @current_user = User.find_by_identity_url(identity_url)
            successful_login
          else
            session[:identity_url] = identity_url
            redirect_to new_user_path
          end
      else
        flash[:notice] = result.message
        render :action => 'new'
      end
    end
    
    
#    self.current_user = User.authenticate(params[:login], params[:password])
#    if logged_in?
#      if params[:remember_me] == "1"
#        current_user.remember_me unless current_user.remember_token?
#        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
#      end
#      redirect_back_or_default('/')
#      flash[:notice] = "Logged in successfully"
#    else
#      render :action => 'new'
#    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
