# Create the database instance.

mysql_database node['mercury']['database']['dbname'] do
  connection(
    :host => node['mercury']['database']['host'],
    :username => node['mercury']['database']['root_username'],
    :password => password_data_bag_item['root_password']
  )
  action :create
end
