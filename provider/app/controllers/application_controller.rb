class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  $contexts = Hash.new

  protect_from_forgery with: :exception

  protected 
  def write_log(c, text)
      logger = Logger.new("#{Rails.root}/log/"+c.id.to_s+'.log')
      logger.formatter = proc do |severity, datetime, progname, msg|
          "#{msg}\n"
      end
      logger.info(text)
  end
end
