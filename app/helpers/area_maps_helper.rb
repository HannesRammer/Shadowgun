module AreaMapsHelper
  def area_map_create_button(area_type, field)
    link_to_remote "add #{area_type} area", :url =>{:controller=>:area_maps,:action=>:add_box, :field=>field, :field_type=>area_type}
  end

  
end
