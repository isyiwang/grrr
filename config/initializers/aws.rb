# TODO(grrr): a sample AWS config
# Hacky solution to this issue: https://github.com/thoughtbot/paperclip/issues/2484
Aws::VERSION = Gem.loaded_specs['aws-sdk'].version
Aws.config.update(
  region: ENV['AWS_DEFAULT_REGION'] || 'us-west-2',
  credentials: Aws::Credentials.new(
    ENV['AWS_ACCESS_KEY_ID'],
    ENV['AWS_SECRET_ACCESS_KEY'],
  ),
)
