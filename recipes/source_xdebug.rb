php_pear "xdebug" do
  action :install
  version node[:php][:pecl_packages][:xdebug][:version]
end

template "#{node['php']['ext_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[php-fpm]"
end
