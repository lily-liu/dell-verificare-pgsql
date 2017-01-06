CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
      provider: 'AWS', # required
      aws_access_key_id: 'AKIAJ3B6D57O2IGVIGAQ', # required
      aws_secret_access_key: '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', # required
      region: 'ap-southeast-1', # optional
  }
  config.fog_directory = 'verificareuploads1' # required
end