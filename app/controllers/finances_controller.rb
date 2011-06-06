class FinancesController < ApplicationController
  # GET /finances
  # GET /finances.xml
  def index
    @finances = Finance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @finances }
    end
  end

  # GET /finances/1
  # GET /finances/1.xml
  def show
    @finance = Finance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @finance }
    end
  end

  # GET /finances/new
  # GET /finances/new.xml
  def new
    @finance = Finance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @finance }
    end
  end

  # GET /finances/1/edit
  def edit
    @finance = Finance.find(params[:id])
  end

  # POST /finances
  # POST /finances.xml
  def create
    @finance = Finance.new(params[:finance])

    respond_to do |format|
      if @finance.save
        flash[:notice] = 'Finance was successfully created.'
        format.html { redirect_to(@finance) }
        format.xml  { render :xml => @finance, :status => :created, :location => @finance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @finance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /finances/1
  # PUT /finances/1.xml
  def update
    @finance = Finance.find(params[:id])

    respond_to do |format|
      if @finance.update_attributes(params[:finance])
        flash[:notice] = 'Finance was successfully updated.'
        format.html { redirect_to(@finance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @finance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /finances/1
  # DELETE /finances/1.xml
  def destroy
    @finance = Finance.find(params[:id])
    @finance.destroy

    respond_to do |format|
      format.html { redirect_to(balance_url) }
      format.xml  { head :ok }
    end
  end

  def main
    @finances = Finance.all
    @current_state = Finance.current_state
  end
end
