CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
      provider: 'AWS', # required
      aws_access_key_id: 'AKIAINCAF4JBFYUFPNAA', # required
      aws_secret_access_key: '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', # required
      region: 'ap-southeast-1', # optional
  }
  config.fog_directory = 'verificareuploads' # required
end