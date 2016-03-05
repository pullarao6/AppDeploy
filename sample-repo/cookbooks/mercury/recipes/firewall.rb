include_recipe 'firewall::default'

ports = node.default['mercury']['open_ports']
firewall_rule "open ports #{ports}" do
  port ports
end
