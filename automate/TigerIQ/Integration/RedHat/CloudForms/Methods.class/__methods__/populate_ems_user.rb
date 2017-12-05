#
# Description: <Method description here>
#

value = nil

param_os_host = $evm.root['dialog_param_os_host'] || nil
$evm.log(:info, "param_os_host: #{param_os_host}")

unless param_os_host.nil?
  ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager').all.detect(:hostname => param_os_host).first

  unless ems.nil?
    value = ems.authentication_userid
    unless value.nil?
      list_values = {
        'required'  => true,
        'protected' => true,
        'read_only' => true,
        'value'     => value,
      }

      list_values.each { |key, value| $evm.object[key] = value }

    end
  end
end
