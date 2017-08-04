#
# Description: <Method description here>
#

$evm.root.attributes.sort.each { |k, v| $evm.log(:info, "\t Attribute: #{k} = #{v}")}

values_hash = {}
values_hash['!'] = '-- select from list --'

#ems = $evm.vmdb(:ExtManagementSystem).find_by(:type=>"ManageIQ::Providers::Openstack::CloudManager")
#ems = $evm.vmdb(:ExtManagementSystem)
ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager')

$evm.log(:info, ems.count)

ems.all.each do |e|
  $evm.log(:info, e.name)
  $evm.log(:info, e.hostname)
  values_hash[e.hostname] = e.name
end

list_values = {
   'sort_by'    => :value,
   'data_type'  => :string,
   'required'   => true,
   'values'     => values_hash
}
list_values.each { |key, value| $evm.object[key] = value }

$evm.log(:info, values_hash.count)
