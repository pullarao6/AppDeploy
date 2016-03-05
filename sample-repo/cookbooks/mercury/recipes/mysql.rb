mysql2_chef_gem 'default' do
  action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Load the secrets file and the encrypted data bag item that holds the root password.
password_secret = Chef::EncryptedDataBagItem.load_secret(node['mercury']['secret_file'])
password_data_bag_item = Chef::EncryptedDataBagItem.load('database_passwords', 'mysql_cust', password_secret)

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password password_data_bag_item['root_password']
  action [:create, :start]
end


#create a databse
mysql_database node['mercury']['database']['dbname'] do
  connection(
    :host => node['mercury']['database']['host'],
    :username => node['mercury']['database']['root_username'],
    :password => password_data_bag_item['root_password']
  )
  action :create
end


#Add a Database user
mysql_database_user node['mercury']['database']['admin_username'] do
  connection(
    :host => node['mercury']['database']['host'],
    :username => node['mercury']['database']['root_username'],
    :password => password_data_bag_item['root_password']
  )
  password password_data_bag_item['admin_password']
  database_name node['mercury']['database']['dbname']
  host node['mercury']['database']['host']
  action [:create, :grant]
end

# Write schema seed file to filesystem.
cookbook_file node['mercury']['database']['create_tables_script'] do
  source 'create-tables.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed the database with a table and test data.
execute "initialize #{node['mercury']['database']['dbname']} database" do
  command "mysql -h #{node['mercury']['database']['host']} -u #{node['mercury']['database']['admin_username']} -p#{password_data_bag_item['admin_password']} -D #{node['mercury']['database']['dbname']} < #{node['mercury']['database']['create_tables_script']}"
  not_if  "mysql -h #{node['mercury']['database']['host']} -u #{node['mercury']['database']['admin_username']} -p#{password_data_bag_item['admin_password']} -D #{node['mercury']['database']['dbname']} -e 'describe customers;'"
end
