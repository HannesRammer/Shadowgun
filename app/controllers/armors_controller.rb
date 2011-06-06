class ArmorsController < ApplicationController
  before_filter :login_required
  # GET /armors
  # GET /armors.xml
  def index
    @armors = Armor.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @armors }
    end
  end

  # GET /armors/1
  # GET /armors/1.xml
  def show
    @armor = Armor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @armor }
    end
  end

  # GET /armors/new
  # GET /armors/new.xml
  def new
    @armor = Armor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @armor }
    end
  end

  # GET /armors/1/edit
  def edit
    @armor = Armor.find(params[:id])
  end

  # POST /armors
  # POST /armors.xml
  def create
    @armor = Armor.new(params[:armor])

    respond_to do |format|
      if @armor.save
        @armor.item_bonis.create(params[:item_bonis])
        flash[:notice] = 'Armor was successfully created.'
        format.html { redirect_to(@armor) }
        format.xml  { render :xml => @armor, :status => :created, :location => @armor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @armor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /armors/1
  # PUT /armors/1.xml
  def update
    @armor = Armor.find(params[:id])

    respond_to do |format|
      if @armor.update_attributes(params[:armor])
        flash[:notice] = 'Armor was successfully updated.'
        format.html { redirect_to(@armor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @armor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /armors/1
  # DELETE /armors/1.xml
  def destroy
    @armor = Armor.find(params[:id])
    @armor.destroy

    respond_to do |format|
      format.html { redirect_to(armors_url) }
      format.xml  { head :ok }
    end
  end
end
