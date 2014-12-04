module OpsworksBashrc
  module HelperMethods

    def app_name
      node[:appname] || node.fetch(:opsworks, {}).fetch(:applications, [{}]).first["slug_name"]
    end

    def app_dir
      begin
        case
        when node[:appdir] then node[:appdir]
        when node[:deploy] then node[:deploy][app_name][:deploy_to]
        when node[:opsworks] then node[:opsworks][:deploy][app_name][:deploy_to]
        end
      rescue => e
      end
    end

  end
end
