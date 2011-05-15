class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :admin_user, :editor_user
  
  def no_action
    redirect_to(posts_url)
  end
 
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def login_required_commenter
    current_user ? true : access_denied
  end
  
  def login_required
	  editor_user or admin_user ? true : access_denied
	end
	
  def admin_required
	  admin_user ? true : access_denied
	end
	
	def access_denied
      respond_to do |format|
        format.html do
          session[:return_to] = request.request_uri
          redirect_to(root_url)
        end
        format.any(:json, :xml) do
        end
      end
  end
  
  def editor_user
    if current_user && current_user.status == 1
     @admin ||= User.find(session[:user_id])
    end
  end
  
  def admin_user
    if current_user && current_user.status == 2
     @admin ||= User.find(session[:user_id])
    end
  end
end
