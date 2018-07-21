CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAI4RZP7HSXO4NVGWA',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'rails-photo-123'
  config.asset_host = "rails-photo-pralics"
  config.cache_storage = :fog
end
