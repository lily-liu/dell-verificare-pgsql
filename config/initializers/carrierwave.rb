CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
      provider: 'AWS', # required
      aws_access_key_id: 'asdasdasdasd', # required
      aws_secret_access_key: 'asdasdasdasdasdasdasdasdasd', # required
      region: 'asdsad-asdasdsad-asdsad', # optional
  }
  config.fog_directory = 'verificareuploads1' # required
end
