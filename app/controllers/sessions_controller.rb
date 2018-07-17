class SessionsController < Clearance::SessionsController
  skip_before_action :require_login,
                     only: [:create_from_facebook, :create_from_google_oauth2, :create_from_microsoft_v2_auth],
                     raise: false

  def new
    render 'web/index'
  end

  def create_from_facebook
    auth_hash = request.env['omniauth.auth']

    user = nil
    authentication = FacebookAuthentication.find_by(uid: auth_hash.uid)
    email = auth_hash.info.email
    return head(401) unless WhitelistedEmail.email_whitelisted?(email)

    if authentication
      invariant(
        authentication.user.email == email,
        'Extant user email does not match that given by Microsoft (they match simply by Facebook OAuth2 uid)',
      )
      authentication.user.update!(name: auth_hash.info.name, image: auth_hash.info.image)
      authentication.update!(
        token: auth_hash.credentials.token,
        refresh_token: auth_hash.credentials.refresh_token,
        expires_at: auth_hash.credentials.expires_at,
      )

      user = authentication.user
    else
      user = User.find_by(email: email)
      if user
        user.update!(name: auth_hash.info.name, image: auth_hash.info.image)
      else
        user = User.create!(
          email: email,
          name: auth_hash.info.name,
          image: auth_hash.info.image,
          password: SecureRandom.hex(32),
        )
      end

      FacebookAuthentication.create!(
        expires_at: auth_hash.credentials.expires_at,
        refresh_token: auth_hash.credentials.refresh_token,
        token: auth_hash.credentials.token,
        uid: auth_hash.uid,
        user: user,
      )
    end

    # Trust Facebook's email verification for confirmation.
    user.update!(confirmed_at: Time.zone.now) if user.confirmed_at.blank?

    sign_in(user)
    redirect_to @next || '/', notice: @notice
  end

  def create_from_google_oauth2
    auth_hash = request.env['omniauth.auth']
    invariant(
      auth_hash.extra.id_info.email_verified,
      'Email is not verified by Google yet.',
    )

    user = nil
    authentication = GoogleAuthentication.find_by(uid: auth_hash.uid)
    email = auth_hash.info.email
    return head(401) unless email_whitelisted?(email)

    if authentication
      invariant(
        authentication.user.email == email,
        'Extant user email does not match that given by Google (they match simply by Google OAuth2 uid)',
      )
      authentication.user.update!(
        name: auth_hash.info.name,
        image: auth_hash.info.image,
      )
      authentication.update!(
        token: auth_hash.credentials.token,
        refresh_token: auth_hash.credentials.try(:refresh_token),
        expires_at: auth_hash.credentials.expires_at,
      )

      user = authentication.user
    else
      user = User.find_by(email: email)
      if user
        user.update!(
          name: auth_hash.info.name,
          image: auth_hash.info.image,
        )
      else
        user = User.create!(
          email: email,
          name: auth_hash.info.name,
          image: auth_hash.info.image,
          password: SecureRandom.hex(32),
        )
      end

      GoogleAuthentication.create!(
        expires_at: auth_hash.credentials.expires_at,
        refresh_token: auth_hash.credentials.try(:refresh_token),
        token: auth_hash.credentials.token,
        uid: auth_hash.uid,
        user: user,
      )
    end

    sign_in(user)
    redirect_to @next || '/', notice: @notice
  end

  def create_from_microsoft_v2_auth
    auth_hash = request.env['omniauth.auth']

    user = nil
    authentication = MicrosoftAuthentication.find_by(uid: auth_hash.uid)
    email_from_auth_hash = auth_hash.extra.raw_info.mail || auth_hash.extra.raw_info.userPrincipalName
    return head(401) unless email_whitelisted?(email_from_auth_hash)

    if authentication
      invariant(
        authentication.user.email == email_from_auth_hash,
        'Extant user email does not match that given by Microsoft (they match simply by Microsoft OAuth2 uid)',
      )
      authentication.user.update!(name: auth_hash.extra.raw_info.displayName, image: nil)
      authentication.update!(
        token: auth_hash.credentials.token,
        refresh_token: auth_hash.credentials.refresh_token,
        expires_at: auth_hash.credentials.expires_at,
      )

      user = authentication.user
    else
      user = User.find_by(email: email_from_auth_hash)
      if user
        user.update!(name: auth_hash.extra.raw_info.displayName)
      else
        user = User.create!(
          email: email_from_auth_hash,
          name: auth_hash.extra.raw_info.displayName,
          password: SecureRandom.hex(32),
        )
      end

      MicrosoftAuthentication.create!(
        expires_at: auth_hash.credentials.expires_at,
        refresh_token: auth_hash.credentials.refresh_token,
        token: auth_hash.credentials.token,
        uid: auth_hash.uid,
        user: user,
      )
    end

    sign_in(user)
    redirect_to @next || '/', notice: @notice
  end
end
