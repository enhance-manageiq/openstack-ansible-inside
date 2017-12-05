#
# Description: <Method description here>
#

values_hash = {}
values_hash['!'] = '-- select from list --'

ems = $evm.vmdb('ManageIQ_Providers_Openstack_CloudManager')

$evm.log(:info, "Provider count: #{ems.count}")

ems.all.each do |e|
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
