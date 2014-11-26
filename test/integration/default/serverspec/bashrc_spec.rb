require 'spec_helper'

describe file('/etc/profile.d/custom_bashrc.sh') do

  context "permissions" do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  context "environment variables" do
    its(:content) { should match 'export OPSWORKS_PRIVATE_IP=1-2-3-4' }
    its(:content) { should match 'export OPSWORKS_HOSTNAME=foo_app_01' }
    its(:content) { should match 'export OPSWORKS_TYPE=t1.micro' }
    its(:content) { should match 'export OPSWORKS_ID=asdfjkl' }
    its(:content) { should match 'export OPSWORKS_ZONE=us-east' }
  end

  context "basic aliases" do
    its(:content) { should match "alias ll='ls -l'" }
    its(:content) { should match "alias la='ls -al'" }
    its(:content) { should match "alias cdc='cd /srv/www/foo_app/current'" }
    its(:content) { should match "alias cds='cd /srv/www/foo_app/shared'" }
    its(:content) { should match "alias psg='sudo ps aux | grep -v grep | grep '" }
  end

end
