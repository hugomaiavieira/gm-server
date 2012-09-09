class ApplicationController < ActionController::Base
  protect_from_forgery

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.params[:api_token] == 'ptdDxFNkqq1hxVnRPXi5' }
end
