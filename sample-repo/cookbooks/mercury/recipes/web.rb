# Install Apache and start the service.
httpd_service 'customers' do
  mpm 'prefork'
  action [:create, :start]
end

# Add the site configuration.
httpd_config 'customers' do
  instance 'customers'
  source 'customers.conf.erb'
  notifies :restart, 'httpd_service[customers]'
end

# Create the document root directory.
directory node['mercury']['document_root'] do
  recursive true
end

# Write the home page.
file "#{node['mercury']['document_root']}/index.html" do
  content '<html>Hello World</html>'
  mode '0644'
  owner 'web_admin'
  group 'web_admin'
end
