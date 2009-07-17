# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :login_required, :except => [:login, :signup_individual,:signup_organization, :logout]
  before_filter :login_from_cookie
  
  PER_PAGE = 10 unless defined? PER_PAGE

  def pages_for(size, options = {})
   default_options = {:per_page => PER_PAGE}
   options = default_options.merge(options)
   #Paginator.new self, size, options[:per_page], (options[:page] || 1)
 end
  
end
