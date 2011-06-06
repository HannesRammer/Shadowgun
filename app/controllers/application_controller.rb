# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time

  def ok(text)
  txt = "<div class='message'>"
    txt << "<a onclick='$(\"message\").innerHTML=\"\"' style='position:absolute;top:0px;right:0px;'>x</a><br/>"
    txt << "#{text}</div>"
    render :update do |page|
      page["message"].replace_html txt
    end
  end

  def f(x, length_after_point)
    #f(x, length_after_point)
    "%.#{length_after_point}f" % x
  end

  def f2(x)
    #f2(x)
      f(x, 2).to_f
  end

  def set_soundfile(flash_output_txt)
    set_soundfile(flash_output_txt)
  end
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery  #:secret => 'e09935e217725f7ac29bb26907604031'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

end
