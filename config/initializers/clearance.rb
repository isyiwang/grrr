Clearance.configure do |config|
  config.routes = false
  # TODO(grrr): This is pretty locked-down, but you can open this up for registration if you'd like.
  config.allow_sign_up = false
  config.secure_cookie = true
  # TODO(grrr): set this to your mailer reply-to address
  # config.mailer_sender = 'noreply@ardius.com'
  config.rotate_csrf_on_sign_in = true
end
