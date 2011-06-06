class AreaMap < ActiveRecord::Base

  def image_file=(input_data)
      self.filename = input_data.original_filename
      self.content_type = input_data.content_type.chomp
      self.binary_data = input_data.read
  end 


  def self.allow_area_for(char, area)
    if area == "wasser"
      true#char.can_swim?
    elsif area == "berg"
      char.can_climb?
    elsif area == "wald"
      true
    elsif area == "error"
      false
    else
      true
    end
  end

  def self.available_areas
    ["error","wasser","berg","wald","town","exit"]
  end

  def self.load_areas(field)
    AreaMap.find_all_by_field(field) || []
  end

  def self.area_for(x,y,f)
    am = AreaMap.find_by_sql("select * from area_maps where field = '#{f}' and x_min < #{x} and  (x_min + x_max) > #{x} and y_min < #{y} and ( y_min + y_max ) > #{y} limit 1")[0]
    am ? am.field_type : "field"
  end
end
