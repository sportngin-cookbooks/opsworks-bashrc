Chef::Resource::Template.send(:include, OpsworksBashrc::HelperMethods)

node.fetch(:opsworks_bashrc, {}).fetch(:custom_source_files, {}).each do |cookbook, file_name|
  directory "/usr/share/custom_bashrc" do
    owner 'root'
    group 'root'
    mode 0755
  end

  cookbook_file "/usr/share/custom_bashrc/#{file_name}" do
    source file_name
    cookbook cookbook
    owner 'root'
    group 'root'
    mode 0644
  end
end

template "/etc/profile.d/custom_bashrc.sh" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode 0644
  data = instance_data

  variables({
    :appdir => app_dir,
    :layers => data[:layers],
    :private_ip => data[:private_ip],
    :hostname => data[:hostname],
    :box_type => data[:box_type],
    :node_id => data[:node_id],
    :zone => data[:zone],
    :custom_env_variables => node.fetch(:opsworks_bashrc, {}).fetch(:custom_env_variables, {}),
    :custom_bash_aliases => node.fetch(:opsworks_bashrc, {}).fetch(:custom_bash_aliases, {}),
    :custom_bash_scripts => node.fetch(:opsworks_bashrc, {}).fetch(:custom_bash_scripts, []),
    :custom_source_files => node.fetch(:opsworks_bashrc, {}).fetch(:custom_source_files, {})
  })
end
