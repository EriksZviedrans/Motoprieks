class MainsController < ApplicationController

  def index
      @category_id = params[:category_id]
    if @category_id == nil
     @mains = Post.paginate :all, :page => params[:page], :conditions => { :status => true },:order => "created_at DESC"
   else 
     @mains = Post.paginate :all, :page => params[:page], :conditions => { :status => true, :category_id =>          @category_id },:order => "created_at DESC"
    end 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mains }
    end
  end

  def show
    @main = Post.find(params[:id], :conditions => { :status => true }) rescue nil
      if @main.nil?
        redirect_to root_url
      else
        respond_to do |format|
          format.html 
          format.xml  { render :xml => @main }
        end
      end
  end
end
