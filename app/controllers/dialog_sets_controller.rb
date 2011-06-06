class DialogSetsController < ApplicationController
  # GET /pc_char_dialog_set_to_user_chars
  # GET /pc_char_dialog_set_to_user_chars.xml
  def index
    @pc_char_dialog_set_to_user_chars = PcCharDialogSetToUserChar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pc_char_dialog_set_to_user_chars }
    end
  end

  # GET /pc_char_dialog_set_to_user_chars/1
  # GET /pc_char_dialog_set_to_user_chars/1.xml
  def show
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pc_char_dialog_set_to_user_char }
    end
  end

  # GET /pc_char_dialog_set_to_user_chars/new
  # GET /pc_char_dialog_set_to_user_chars/new.xml
  def new
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pc_char_dialog_set_to_user_char }
    end
  end

  # GET /pc_char_dialog_set_to_user_chars/1/edit
  def edit
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.find(params[:id])
  end

  # POST /pc_char_dialog_set_to_user_chars
  # POST /pc_char_dialog_set_to_user_chars.xml
  def create
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.new(params[:pc_char_dialog_set_to_user_char])

    respond_to do |format|
      if @pc_char_dialog_set_to_user_char.save
        flash[:notice] = 'PcCharDialogSetToUserChar was successfully created.'
        format.html { redirect_to(@pc_char_dialog_set_to_user_char) }
        format.xml  { render :xml => @pc_char_dialog_set_to_user_char, :status => :created, :location => @pc_char_dialog_set_to_user_char }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pc_char_dialog_set_to_user_char.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pc_char_dialog_set_to_user_chars/1
  # PUT /pc_char_dialog_set_to_user_chars/1.xml
  def update
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.find(params[:id])

    respond_to do |format|
      if @pc_char_dialog_set_to_user_char.update_attributes(params[:pc_char_dialog_set_to_user_char])
        flash[:notice] = 'PcCharDialogSetToUserChar was successfully updated.'
        format.html { redirect_to(@pc_char_dialog_set_to_user_char) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pc_char_dialog_set_to_user_char.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pc_char_dialog_set_to_user_chars/1
  # DELETE /pc_char_dialog_set_to_user_chars/1.xml
  def destroy
    @pc_char_dialog_set_to_user_char = PcCharDialogSetToUserChar.find(params[:id])
    @pc_char_dialog_set_to_user_char.destroy

    respond_to do |format|
      format.html { redirect_to(pc_char_dialog_set_to_user_chars_url) }
      format.xml  { head :ok }
    end
  end
end
