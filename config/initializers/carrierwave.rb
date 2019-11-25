CarrierWave.configure do |config|
  storage = case Rails.env
            when 'staging', 'production'
              :fog
            else
              :file
            end

  config.storage = storage

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_REGION']
  }

  config.fog_directory  = ENV['AWS_BUCKET_NAME']
end
