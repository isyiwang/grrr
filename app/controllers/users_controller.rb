class UsersController < Clearance::UsersController
  skip_before_action :require_login, only: [:sign_up], raise: false

  def sign_up
    return redirect_to '/' if signed_in?
    render 'web/index'
  end
end
