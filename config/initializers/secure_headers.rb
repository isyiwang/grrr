# rubocop:disable Lint/PercentStringArray
SecureHeaders::Configuration.default do |config|
  config.cookies = {
    httponly: true,
    samesite: { lax: true },
    secure: true,
  }

  # HSTS. cf. https://www.owasp.org/index.php/HTTP_Strict_Transport_Security_Cheat_Sheet
  config.hsts = "max-age=#{1.week.to_i}; includeSubDomains"

  # Prevents our site being iframed, cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
  config.x_frame_options = 'DENY'

  # Prevents MIME-type sniffing of style and script resources.
  # cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
  config.x_content_type_options = 'nosniff'

  # For older browsers that don't support Content Security Policy.
  # cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
  config.x_xss_protection = '1; mode=block'

  # For IE8 (lol) -- prevents automatic opening of downloaded resources.
  config.x_download_options = 'noopen'

  # Tells the browser that there is no cross-domain policy XML file anywhere and to just
  # do what we say here in the Content Security Policy.
  # cf. https://www.owasp.org/index.php/OWASP_Secure_Headers_Project#xpcdp
  config.x_permitted_cross_domain_policies = 'none'

  # The referrer header is set to the full URL when it's the same origin (ardius.com), but
  # domain-only when cross-origin. This protects our users' privacy.
  # cf. https://www.owasp.org/index.php/OWASP_Secure_Headers_Project#rp
  config.referrer_policy = 'origin-when-cross-origin'

  script_srcs = [
    '\'self\'',
    'https://www.google-analytics.com',
    'https://code.jquery.com',
    'https://maxcdn.bootstrapcdn.com',
    'https://cdnjs.cloudflare.com',
  ]
  script_srcs.push('\'unsafe-inline\'') if Rails.env.development? # To enable /graphiql

  # The Content Security Policy-proper directives.
  # cf. https://www.owasp.org/index.php/OWASP_Secure_Headers_Project#csp
  #     and https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy
  config.csp = {
    preserve_schemes: true,

    # Fallback in case a specific directive is not found.
    default_src: %w['self'],

    # Relative urls are to be relative to the current origin (localhost:3000 or ardius.com).
    base_uri: %w['self'],

    block_all_mixed_content: true, # prevents loading of http + https mixed content

    child_src: %w['self'], # we can only frame URLs from our own (current) domain

    # This restricts which URLs can be loaded by scripts, e.g. via fetch, <a> elements, ajax, sockets, etc.
    # cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/connect-src
    connect_src: %w['self' ws://localhost:3035 http://localhost:3035 https://sentry.io],

    # Can only fetch fonts from our own domain.
    font_src: %w['self' https://maxcdn.bootstrapcdn.com https://fonts.googleapis.com https://fonts.gstatic.com],

    # Can only submit forms to our own domain.
    form_action: %w['self'],

    # We don't allow ourselves to be framed currently. If you want to, you will need to change to 'self'.
    frame_ancestors: %w['none'],

    # TODO(abe/isaac): add cdn domain when we get there
    img_src: %w['self' data: blob: https://www.google-analytics.com https://*.amazonaws.com https://*.unsplash.com],

    # This only really applies to installable web-apps but we default here to our own domain.
    manifest_src: %w['self'],

    # From where can <audio> or <video> sources be loaded. We don't use those media currently so it's off.
    media_src: %w['none'],

    # This prevents <object>, <embed>, or <applet> tags fetching stuff like Flash.
    object_src: %w['none'],

    # Note: plugin_types is not set because, according to
    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/plugin-types:
    # To disallow all plugins, the object-src directive should be set to 'none' which will disallow plugins.
    # The plugin-types directive is only used if you are allowing plugins with object-src at all.

    # Disallows any inline scripts (i.e. preventing XSS).
    script_src: script_srcs,

    # Allows us to have inline styles on HTML elements.
    style_src: [
      '\'self\'',
      '\'unsafe-inline\'',
      'https://maxcdn.bootstrapcdn.com',
      'https://cdnjs.cloudflare.com',
      'https://fonts.googleapis.com',
    ],

    # Web workers. cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/worker-src
    worker_src: %w['self'],

    # Browser will literally re-write requests to http:// URLs on our site to https://. Neat!
    # cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/upgrade-insecure-requests
    upgrade_insecure_requests: !Rails.env.development?,
  }
end
# rubocop:enable Lint/PercentStringArray
