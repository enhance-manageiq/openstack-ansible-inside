#
# Description: <Method description here>
#

values_hash = {}
values_hash['!'] = '-- select from list --'

param_os_host = $evm.root['dialog_param_os_host'] || nil
$evm.log(:info, "param_os_host: #{param_os_host}")

unless param_os_host.nil?
  ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager').all.detect(:hostname => param_os_host).first

  unless ems.nil?
    ems.network_manager.private_networks.each do |n|
      values_hash[n.ems_ref] = n.name
    end

    $evm.log(:info, "values_hash: #{values_hash}")

    list_values = {
      'sort_by'   => :value,
      'data_type' => :string,
      'read_only' => false,
      'values'    => values_hash
      }

    $evm.log(:info, "list_values: #{list_values}")

    list_values.each { |key, value| $evm.object[key] = value }
  end
end

