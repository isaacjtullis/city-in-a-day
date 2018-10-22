# CarrierWave.configure do |config|
#   if !Rails.env.test?
#     config.fog_credentials = {
#       provider:          'AWS',
#       aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#       aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
#     }
#     config.fog_directory  = ENV["S3_BUCKET"]
#   end
# end
CarrierWave.configure do |config|
  if !Rails.env.test?
    config.fog_credentials = {
      provider:          'AWS',
      aws_access_key_id: "AKIAIMEDYWLENLK7NJQQ",
      aws_secret_access_key: "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"
    }
    config.fog_directory  = "city-in-a-day-development"
  end
end
