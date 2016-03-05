default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['mercury']['open_ports'] = 80
default['mercury']['user'] = 'web_admin'
default['mercury']['group'] = 'web_admin'
default['mercury']['document_root'] = '/var/www/customers/public_html'
default['mercury']['secret_file'] = '/etc/chef/encrypted_data_bag_secret'

default['mercury']['database']['dbname'] = 'my_company'
default['mercury']['database']['host'] = '127.0.0.1'
default['mercury']['database']['root_username'] = 'root'

default['mercury']['database']['admin_username'] = 'db_admin'

default['mercury']['database']['create_tables_script'] ='/tmp/create-tables.sql'
