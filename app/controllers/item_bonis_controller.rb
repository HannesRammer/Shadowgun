class ItemBonisController < ApplicationController
  before_filter :login_required
  # GET /item_bonis
  # GET /item_bonis.xml
   def index
    @owner = find_owner
    if params[:admin] == "true"
      @item_bonis = ItemBoni.find(:all)
      find_boni

    else
      @item_bonis = @owner.item_bonis
    end
  end

  # GET /item_bonis/1
  # GET /item_bonis/1.xml
  def show
    @item_boni = ItemBoni.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_boni }
    end
  end

  # GET /item_bonis/new
  # GET /item_bonis/new.xml
  def new
    @item_boni = ItemBoni.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_boni }
    end
  end

  # GET /item_bonis/1/edit
  def edit
    @item_boni = ItemBoni.find(params[:id])
  end

  # POST /item_bonis
  # POST /item_bonis.xml
  def create
    @item_boni = ItemBoni.new(params[:item_boni])

    respond_to do |format|
      if @item_boni.save
        flash[:notice] = 'ItemBoni was successfully created.'
        format.html { redirect_to(@item_boni) }
        format.xml  { render :xml => @item_boni, :status => :created, :location => @item_boni }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_boni.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /item_bonis/1
  # PUT /item_bonis/1.xml
  def update
    @item_boni = ItemBoni.find(params[:id])

    respond_to do |format|
      if @item_boni.update_attributes(params[:item_boni])
        flash[:notice] = 'ItemBoni was successfully updated.'
        format.html { redirect_to(@item_boni) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_boni.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /item_bonis/1
  # DELETE /item_bonis/1.xml
  def destroy
    @item_boni = ItemBoni.find(params[:id])
    @item_boni.destroy

    respond_to do |format|
      format.html { redirect_to(item_bonis_url) }
      format.xml  { head :ok }
    end
  end

  def find_owner
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      else
        return false
      end
    end
    nil
  end

end
