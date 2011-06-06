class WeaponsController < ApplicationController
  before_filter :login_required
  # GET /weapons
  # GET /weapons.xml
  def index
    @weapons = Weapon.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weapons }
    end
  end

  # GET /weapons/1
  # GET /weapons/1.xml
  def show
    @weapon = Weapon.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weapon }
    end
  end

  # GET /weapons/new
  # GET /weapons/new.xml
  def new
    @weapon = Weapon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weapon }
    end
  end

  # GET /weapons/1/edit
  def edit
    @weapon = Weapon.find(params[:id])
  end

  # POST /weapons
  # POST /weapons.xml
  def create
    @weapon = Weapon.new(params[:weapon])
    respond_to do |format|
      if @weapon.save
        @weapon.item_bonis.create(params[:item_bonis])
        flash[:notice] = 'Weapon was successfully created.'
        format.html { redirect_to(@weapon) }
        format.xml  { render :xml => @weapon, :status => :created, :location => @weapon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weapon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weapons/1
  # PUT /weapons/1.xml
  def update
    @weapon = Weapon.find(params[:id])

    respond_to do |format|
      if @weapon.update_attributes(params[:weapon])
        flash[:notice] = 'Weapon was successfully updated.'
        format.html { redirect_to(@weapon) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weapon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weapons/1
  # DELETE /weapons/1.xml
  def destroy
    @weapon = Weapon.find(params[:id])
    @weapon.destroy

    respond_to do |format|
      format.html { redirect_to(weapons_url) }
      format.xml  { head :ok }
    end
  end

  def pick_up
    wtc = w_t_c_id_to_wtc(params[:wtc_id])
    weapon = wtc.weapon
    @current_char.pick_up(wtc.weapon_id)

    render :update do |page|
      page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{  :wtcs => @current_char.character_to_weapon}
      page["results"].replace_html :partial => "characters/results"
      page["notice"].replace_html "Waffe #{weapon.name} gefunden."
    end
  end

  def drop
    wtc = w_t_c_id_to_wtc(params[:wtc_id])
    weapon = wtc.weapon
    @current_char.drop(wtc)

    render :update do |page|
      page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{  :wtcs => @current_char.character_to_weapon}
      page["results"].replace_html :partial => "characters/results"
      page["notice"].replace_html "Waffe #{weapon.name} gedropt."
    end
  end

  def use
    wtc = w_t_c_id_to_wtc(params[:wtc_id])
    weapon = wtc.weapon
    @current_char.use_weapon(wtc)

    render :update do |page|
      page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{  :wtcs => @current_char.character_to_weapon}
      page["results"].replace_html :partial => "characters/results"
      page["notice"].replace_html "Waffe #{weapon.name} wird benutzt."
    end
  end


  def unuse
    wtc = w_t_c_id_to_wtc(params[:wtc_id])
    weapon = wtc.weapon
    char.unuse_item(weapon)

    render :update do |page|
      page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{   :wtcs => @current_char.character_to_weapon}
      page["results"].replace_html :partial => "characters/results"
      page["notice"].replace_html "Waffe #{weapon.name} weg gelegt."
    end
  end

  def w_t_c_id_to_wtc(wtc_id)
    CharacterToWeapon.find_by_id(wtc_id)
  end

end
