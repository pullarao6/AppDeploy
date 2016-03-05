include_recipe 'iptables::default'

iptables_rule 'http' do
  action :enable
end
