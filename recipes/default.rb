Chef::Resource::Template.send(:include, OpsworksBashrc::HelperMethods)

template "/etc/profile.d/custom_bashrc.sh" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :appdir => app_dir,
    :layers => node[:opsworks][:instance][:layers],
    :private_ip => node[:opsworks][:instance][:private_ip],
    :hostname => node[:opsworks][:instance][:hostname],
    :box_type => node[:opsworks][:instance][:instance_type],
    :node_id => node[:opsworks][:instance][:aws_instance_id],
    :zone => node[:opsworks][:instance][:availability_zone],
    :custom_env_variables => node.fetch(:opsworks_bashrc, {}).fetch(:custom_env_variables, {}),
    :custom_bash_aliases => node.fetch(:opsworks_bashrc, {}).fetch(:custom_bash_aliases, {})
  })
end
