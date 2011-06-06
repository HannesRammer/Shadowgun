class CharactersController < ApplicationController
  before_filter :login_required

  # GET /characters
  # GET /characters.xml
  def index
    @characters = [@current_char] # Character.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    @character = @current_char #Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  def new
    @character = Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = @current_char

  end

  # def _user_edit
  #return flash[:notice] = "kein user" unless @user
  #  @character = @user.character
#  end
  # POST /characters
  # POST /characters.xml
  def create
    @character = Character.new(params[:character])

    respond_to do |format|
      if @character.save
        flash[:notice] = 'Character was successfully created.'
        c = Coordinates.new()
        c.x = rand(300)
        c.y = rand(300)
        c.character_id = @character.id
        if c.save
          flash[:notice] << " coordinaten generiert"
        end
        format.html { redirect_to(@character) }
        format.xml { render :xml => @character, :status => :created, :location => @character }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  def generate
    msg =""
    if @current_account.character.nil?
      msg = Character.generate_character(@current_account)
    elsif !@current_account.character.nil?

      if params[:finish] == "step1"
        @current_char.name = params[:character][:name]
        msg = " Charakter name gespeichert;" if @current_char.save
        race_id = params[:race][:race_id]
        if !race_id.blank?
          ctr = CharacterToRace.find_by_character_id(@current_char.id) || CharacterToRace.new
          ctr.character_id= @current_char.id
          race = Race.find_by_id(race_id)
          ctr.race_id= race_id
          msg << " Rasse #{race.name} saved;" if ctr.save
          @current_char.path.destroy if @current_char.path
          @current_char.vocation.destroy if @current_char.vocation
          @current_char.path.save if @current_char.path
          path_id = params[:path][:path_id]
          if !path_id.blank?
            ctp = CharacterToPath.find_by_character_id(@current_char.id) || CharacterToPath.new
            ctp.character_id= @current_char.id
            path = Path.find_by_id(path_id)
            ctp.path_id = path_id
            path_ok = race.paths.index(path)
            if path_ok
              msg << " Pfad #{path.name} saved;" if ctp.save
            end
            vocation_id = params[:vocation][:vocation_id]
            if !vocation_id.blank?
              ctv = CharacterToVocation.find_by_character_id(@current_char.id) || CharacterToVocation.new
              ctv.character_id= @current_char.id
              vocation = Vocation.find_by_id(vocation_id)
              ctv.vocation_id = vocation_id
              vocation_ok = !path.vocations.index(vocation).blank?
              if vocation_ok && path_ok
                msg << " Weg #{vocation.name} saved;" if ctv.save
              end
            end
          end
        end
        #reload values for ability replace_html
        @current_char = Character.find(@current_char.id)
        render :update do |page|
          page["abilities"].replace_html :partial=>"characters/ability"
          page["race"].replace_html :partial=>"characters/race"

          page["notice"].replace_html msg
        end
      end
    end
    flash.now[:notice]= msg
  end

  def find_path
    return unless race = Race.find_by_id(params[:race_id])
    render :update do |page|
      page["path"].replace_html :partial=>"characters/path", :locals=>{:paths=>race.paths}
    end
  end

  def find_vocation
    return unless path = Path.find_by_id(params[:path_id])
    render :update do |page|
      page["vocation"].replace_html :partial=>"characters/vocation", :locals=>{:vocations=>path.vocations}
    end
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    @character = @current_char #Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        flash[:notice] = 'Character was successfully updated.'
        format.html { redirect_to(@character) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(characters_url) }
      format.xml { head :ok }
    end
  end


  def increase_attribute
    char = @current_char
    if char.free_attribute_points > 0
      x = params[:attribute]

      eval "char.#{x} += 1"
      char.save
      msg = "#{x} gesteigert"
    else
      msg = "keine punkte zum verteilen übrig"
    end
    render :update do |page|
      page["attributes"].replace_html :partial => "characters/attributes", :locals=>{:character => char}
      page["results"].replace_html :partial => "characters/results", :locals=>{:character => char}

      page["notice"].replace_html msg
    end
  end

  def decrease_attribute
    char = @current_char
    x = params[:attribute]
    if eval("char.#{x} > 1")
      eval "char.#{x} -= 1"
      char.save
      msg = "#{x} gesunken"
    else
      msg = "#{x} kann nicht reduziert werden"
    end
    render :update do |page|
      page["attributes"].replace_html :partial => "characters/attributes", :locals=>{:character => char}
      page["results"].replace_html :partial => "characters/results", :locals=>{:character => char}
      page["notice"].replace_html msg
    end
  end

  def buff
    ab = nil
    buff_id = params[:buff_id].to_i
    use_on_char = params[:char_1].to_i
    if @current_char.active_ability_ids.index(buff_id)
      ab = Ability.find_by_id(buff_id)
      ab.duration_sec.seconds == 0 ? valid_for = 3600 * 24 : valid_for = ab.duration_sec.seconds
      valid_till = Time.now + valid_for
      valid_times = ab.active_times
      if ctaa = CharacterToActiveAbility.find_by_ability_id_and_character_id(buff_id, use_on_char)
        ctaa.valid_till = valid_till
        ctaa.valid_from = Time.now
        ctaa.valid_times = valid_times
        ctaa.save
      else
        CharacterToActiveAbility.create(:ability_id=>buff_id, :character_id=>use_on_char, :valid_till=>valid_till, :valid_from=>Time.now, :valid_times=>valid_times, :usage_type=>ab.usage_type)
      end
    end
    render :update do |page|
      if params[:current_page] == "characters"


        page["results"].replace_html :partial => "characters/results", :locals=>{:character => @current_char}

      elsif params[:current_page] == "fight"
      else
        page["c#{use_on_char}_effect_script_div"].replace_html javascript_tag("start_buff_effect_on('#{use_on_char}', '##{ab.effect_color}', '##{ability_level_color_code(ab.level)}')")

      end
    end
  end
end
