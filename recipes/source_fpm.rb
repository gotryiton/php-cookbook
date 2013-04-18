include_recipe "php::source_54"

%w{ fpm cgi fpm/pool.d }.each do |dir|
  directory "#{node['php']['etc_dir']}/#{dir}" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
  end
end

cookbook_file "/etc/init.d/php-fpm" do
  source "php-fpm.init"
  owner "root"
  group "root"
  mode "0755"
end

template "fpm_php.ini" do
  path "#{node['php']['etc_dir']}/fpm/php.ini"
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "cgi_php.ini" do
  path "#{node['php']['etc_dir']}/cgi/php.ini"
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "www.conf" do
  path "#{node['php']['etc_dir']}/fpm/pool.d/www.conf"
  source "www.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "php-fpm.conf" do
  path "#{node['php']['etc_dir']}/fpm/php-fpm.conf"
  source "php-fpm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

service "php-fpm" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

service "php-fpm" do
  subscribes :restart, resources(
      :template => "www.conf",
      :template => "cgi_php.ini",
      :template => "fpm_php.ini",
      :template => "php-fpm.conf"
    )
end

include_recipe "monit"

template "/etc/monit/conf.d/php-fpm.conf" do
  owner 'root'
  group 'root'
  mode 00644
  source 'php-fpm_monit.conf.erb'
  notifies :restart, "service[monit]"
end
