app_name = node[:appname] || node[:opsworks][:applications].first["slug_name"]

template "/etc/profile.d/custom_bashrc.sh" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :layers => node[:opsworks][:instance][:layers],
    :node_app => node.keys.include?("opsworks_nodejs"),
    :appdir => (node[:appdir] || node[:opsworks][:deploy][app_name][:deploy_to]),
    :app_env => (node[:node_env] || node[:rails_env]),
    :private_ip => node[:opsworks][:instance][:private_ip],
    :hostname => node[:opsworks][:instance][:hostname],
    :box_type => node[:opsworks][:instance][:instance_type],
    :node_id => node[:opsworks][:instance][:aws_instance_id],
    :zone => node[:opsworks][:instance][:availability_zone]
  })
end