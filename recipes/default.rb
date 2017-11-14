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
  settings = app_settings

  variables({
    :appdir => app_dir,
    :layers => settings[:layers],
    :private_ip => settings[:private_ip],
    :hostname => settings[:hostname],
    :box_type => settings[:box_type],
    :node_id => settings[:node_id],
    :zone => settings[:zone],
    :custom_env_variables => node.fetch(:opsworks_bashrc, {}).fetch(:custom_env_variables, {}),
    :custom_bash_aliases => node.fetch(:opsworks_bashrc, {}).fetch(:custom_bash_aliases, {}),
    :custom_bash_scripts => node.fetch(:opsworks_bashrc, {}).fetch(:custom_bash_scripts, []),
    :custom_source_files => node.fetch(:opsworks_bashrc, {}).fetch(:custom_source_files, {})
  })
end
