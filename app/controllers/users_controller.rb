class UsersController < ApplicationController
  before_filter :admin_required, :except => ["new", "create", "index", "show"]
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.status = 0
    @user.status = 2 if  @user.login == "eriks"

    if @user.save
      redirect_to root_url, :notice =>"Signed Up!"
    else
      render "new"
    end  
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:back, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
