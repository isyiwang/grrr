class WhitelistedEmailGuard < Clearance::SignInGuard
  def call
    if ::WhitelistedEmail.email_whitelisted?(user.email)
      next_guard
    else
      failure('Ask us for an invite!')
    end
  end
end
