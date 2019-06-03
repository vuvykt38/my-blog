CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: ENV['s3_region']
  }
  config.fog_directory  = ENV['s3_bucket']
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
