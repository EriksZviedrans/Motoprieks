class ImagesController < ApplicationController
  before_filter :login_required, :except => ["code_image"]
  def index
    @images = Image.all
    respond_to do |format|
      format.html
      format.xml  { render :xml => @images }
    end
  end
  
  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @image }
    end
  end
   
  def new
    @image = Image.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @image }
    end
  end
  
  def edit
     @image = Image.find(params[:id])
  end
  
  def create
    @image = Image.new(params[:image])
    respond_to do |format|
      if @image.save
        format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def code_image 
    @image_data = Image.find(params[:id])
    @image = @image_data.binary_data
    send_data @image, :type => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline'
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
end
