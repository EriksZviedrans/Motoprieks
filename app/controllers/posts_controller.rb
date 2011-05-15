class PostsController < ApplicationController
 before_filter :login_required
 
uses_tiny_mce(:options => {:theme => 'advanced',
  :browsers => %w{msie gecko},
  :theme_advanced_toolbar_location => "top",
  :theme_advanced_toolbar_align => "left",
  :theme_advanced_resizing => true,
  :theme_advanced_resize_horizontal => false,
  :paste_auto_cleanup_on_paste => true,
  :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect bold italic underline strikethrough separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist forecolor backcolor},
  :theme_advanced_buttons2 => %w{ link unlink undo redo emotions },
  :theme_advanced_buttons3 => [],
  :plugins => %w{contextmenu paste emotions}},
  :only => [:new, :create, :edit, :update, :show]) 
  
  $categories = Category.all
  $users = User.all
  $images = Image.all

  def index
    @posts = Post.find(:all,:order => "created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
  @post = Post.find(params[:id]) rescue nil
  if @post.nil?
  redirect_to root_url
  else
   respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = session[:user_id] if !admin_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
end
