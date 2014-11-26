app_name = node[:appname] || node.fetch(:opsworks, {}).fetch(:applications, [{}]).first["slug_name"]
appdir = begin
           case
           when node[:appdir] then node[:appdir]
           when node[:deploy] then node[:deploy][app_name][:deploy_to]
           when node[:opsworks] then node[:opsworks][:deploy][app_name][:deploy_to]
           end
         rescue => e
           nil
         end

template "/etc/profile.d/custom_bashrc.sh" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :layers => node[:opsworks][:instance][:layers],
    :appdir => appdir,
    :private_ip => node[:opsworks][:instance][:private_ip],
    :hostname => node[:opsworks][:instance][:hostname],
    :box_type => node[:opsworks][:instance][:instance_type],
    :node_id => node[:opsworks][:instance][:aws_instance_id],
    :zone => node[:opsworks][:instance][:availability_zone]
  })
end
