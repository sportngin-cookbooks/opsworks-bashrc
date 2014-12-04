# AWS credentials from a local file
if fog_file = File.expand_path('~/.fog') and File.exists?(fog_file)
  fog_file = YAML.load_file(fog_file)
  ENV['AWS_ACCESS_KEY_ID'] ||= fog_file.fetch('travis-ci', {})['aws_access_key_id']
  ENV['AWS_SECRET_ACCESS_KEY'] ||= fog_file.fetch('travis-ci', {})['aws_secret_access_key']
  ENV['AWS_KEYPAIR_NAME'] ||= fog_file.fetch('travis-ci', {})['aws_keypair_name']
  ENV['EC2_SSH_KEY_PATH'] ||= File.expand_path('~/.ssh/id_rsa_kitchen_ec2')
end
