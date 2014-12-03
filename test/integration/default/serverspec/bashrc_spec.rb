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

  context "custom environment variables" do
    its(:content) { should match '# Custom ENV variables' }
    its(:content) { should match 'export RAILS_ENV=production' }
    its(:content) { should match 'export FOO_BAR=baz' }
  end

  context "custom bash aliases" do
    its(:content) { should match '# Custom bash aliases' }
    its(:content) { should match "alias grep='grep --colour=auto'" }
    its(:content) { should match /alias console='cdc; sudo bundle exec rails console \$RAILS_ENV'/ }
    its(:content) { should match "alias hw='echo \"hello world\"'" }
  end

  context "custom bash scripts" do
    its(:content) { should match '# Custom bash scripts' }
    its(:content) { should match 'new_lib_path=`ls -p /opt/lib/foo_lib/versions/ | grep "/" | sort | head -1`' }
    its(:content) { should match /export PATH=\$PATH:\$new_lib_path/ }
    its(:content) { should match /export PATH=\$PATH:\/the\/best\/lib\/evar\/bin\// }
  end

  context "basic aliases" do
    its(:content) { should match "alias ll='ls -l'" }
    its(:content) { should match "alias la='ls -al'" }
    its(:content) { should match "alias cdc='cd /srv/www/foo_app/current'" }
    its(:content) { should match "alias cds='cd /srv/www/foo_app/shared'" }
    its(:content) { should match "alias psg='sudo ps aux | grep -v grep | grep '" }
  end

end
