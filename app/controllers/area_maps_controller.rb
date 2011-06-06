class AreaMapsController < ApplicationController
  # GET /area_maps
  # GET /area_maps.xml
  def index
    @area_maps = AreaMap.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @area_maps }
    end
  end

  # GET /area_maps/1
  # GET /area_maps/1.xml
  def show
    @area_map = AreaMap.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @area_map }
    end
  end

  # GET /area_maps/new
  # GET /area_maps/new.xml
  def new
    @area_map = AreaMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @area_map }
    end
  end

  # GET /area_maps/1/edit
  def edit
    @area_map = AreaMap.find(params[:id])
  end

  # POST /area_maps
  # POST /area_maps.xml
  def create
    @area_map = AreaMap.new(params[:area_map])

    respond_to do |format|
      if @area_map.save
        flash[:notice] = 'AreaMap was successfully created.'
        format.html { redirect_to(@area_map) }
        format.xml { render :xml => @area_map, :status => :created, :location => @area_map }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @area_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /area_maps/1
  # PUT /area_maps/1.xml
  def update
    @area_map = AreaMap.find(params[:id])

    respond_to do |format|
      if @area_map.update_attributes(params[:area_map])
        flash[:notice] = 'AreaMap was successfully updated.'
        format.html { redirect_to :action=>:show,:id=>@area_map.id }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @area_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /area_maps/1
  # DELETE /area_maps/1.xml
  def destroy
    @area_map = AreaMap.find(params[:id])
    @area_map.destroy

    respond_to do |format|
      format.html { redirect_to(area_maps_url) }
      format.xml { head :ok }
    end
  end

  def new_area_map

    @field = params[:field] || "1_2"
    if @field.include?('town') || @field.include?('room')
      @town_room_id = @field.split('_')[1]#AreaMap.find_by_id(@field.split('_')[1]).id
    end
    @maps = AreaMap.find_all_by_field(@field)

  end

  def add_box
    @field = params[:field] || "1_2"
    if @field.include?('town') || @field.include?('room')
      @town_room_id = @field.split('_')[1]#AreaMap.find_by_id(@field.split('_')[1]).id
    end
    am = AreaMap.new
    am.field=@field
    am.field_type=params[:field_type]
    am.x_min = 0
    am.x_max = 50
    am.y_min = 0
    am.y_max = 50
    am.save
    @maps = AreaMap.find_all_by_field(@field)
    render :update do |page|
      page["area_maps"].replace_html :partial=>"area_maps/area_map"
    end
  end

  def save_area_map
    #x_min = left css
    #y_min = top css
    #x_max = width css
    #y_max = height css
    field = params[:field]
    min_x = params[:min_x]
    max_x = params[:max_x]
    min_y = params[:min_y]
    max_y = params[:max_y]
    map_id = params[:map_id]
    am = AreaMap.find_by_id(map_id)
    render :nothing => true if !am
    am.field = field
    am.x_min = min_x
    am.x_max = max_x
    am.y_min = min_y
    am.y_max = max_y
    am.save
    render :nothing => true if am

  end

  def delete_area
    @field = params[:field] || "1_2"
    am = AreaMap.find params[:id]
    am.destroy if am
    @maps = AreaMap.find_all_by_field(@field)
    render :update do |page|
      page["area_maps"].replace_html :partial=>"area_maps/area_map"
    end
  end

  def code_image
          @image_data = AreaMap.find(params[:id]) 
          @image = @image_data.binary_data
          send_data(@image, :type => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline')
  end
end
