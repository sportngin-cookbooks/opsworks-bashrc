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

    def instance_data
      if node[:opsworks]
        { layers: node[:opsworks][:instance][:layers],
          private_ip: node[:opsworks][:instance][:private_ip],
          hostname: node[:opsworks][:instance][:hostname],
          box_type: node[:opsworks][:instance][:instance_type],
          node_id: node[:opsworks][:instance][:aws_instance_id],
          zone: node[:opsworks][:instance][:availability_zone]
        }
      else
        instance = search("aws_opsworks_instance", "self:true").first

        { layers: instance['layer_ids'],
          private_ip: instance['private_ip'],
          hostname: instance['hostname'],
          box_type: instance['instance_type'],
          node_id: instance['instance_id'],
          zone: instance['availability_zone']
        }
      end
    end
  end
end
