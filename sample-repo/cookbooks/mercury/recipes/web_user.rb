group node['mercury']['group']

user node['mercury']['user'] do
  group node['mercury']['group']
  system true
  shell '/bin/bash'
end
