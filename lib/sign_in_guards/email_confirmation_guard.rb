class EmailConfirmationGuard < Clearance::SignInGuard
  def call
    if current_user.confirmed_at.present?
      next_guard
    else
      failure('Please confirm your email before signing in.')
    end
  end
end
