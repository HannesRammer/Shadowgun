class ItemsController < ApplicationController
  before_filter :login_required
  # GET /items
  # GET /items.xml
  def index
    @items = Item.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        @item.item_bonis.create(params[:item_bonis])
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml { head :ok }
    end
  end

  def quest_item_used
    i = Item.find_by_id(params[:quest_item_id])
    a = Character.find_by_id(params[:char_1])
    d = Character.find_by_id(params[:attacked_char])
    if d.quest_owner_id != 0
    quest = d.belongs_to_quest
      if i.name == "Heiliges Abführmittel" && d.name == "MJ THRILLER"
        d.destroy
        increase_quest_step(quest.id, a.id) if Quest.last_enemy_for_this_status(a.id, quest.id)
      end
    end
  end

  def increase_quest_step(quest_id, user_char_id)
    Quest.set_status_for_user_char(quest_id, user_char_id, Quest.status_for_user_char(user_char_id, quest_id) + 1)
  end

  def use_on_me
    Item.find_by_id(params[:item_id]).use_on(@current_char)
    render :update do |page| 

      page["inventar"].replace :partial => "inventar/main"
    end
  end
end
