#
# Description: <Method description here>
#

value = nil

param_os_host = $evm.root['dialog_param_os_host'] || nil
$evm.log(:info, param_os_host)

unless param_os_host.nil?
  #ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager').find_by(:hostname => param_os_host)
  ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager')

  ems.all.each do |e|
    value = e.authentication_password if e.hostname == param_os_host
  end

  unless value.nil?
    list_values = {
      'required'  => true,
      'protected' => false,
      'read_only' => true,
      'value'     => value,
    }
    list_values.each do |key, value| 
      $evm.object[key] = value
    end
  end
end
