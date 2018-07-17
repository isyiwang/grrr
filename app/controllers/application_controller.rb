class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  before_action :require_login

  rescue_from Exception do |e|
    # TODO(Abe): handle outgoing exceptions to handle some more gracefully
    raise e
  end
end
