include_recipe "php::source_common"

version = node['php']['54_version']
configure_options = node['php']['54_configure_options'].join(" ")

remote_file "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.bz2" do
  source "#{node['php']['url']}/php-#{version}.tar.bz2"
  checksum node['php']['checksum']
  mode "0644"
  not_if "php -v | grep #{version}"
end

bash "build php" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar -jxvf php-#{version}.tar.bz2
    (cd php-#{version} && ./configure #{configure_options})
    (cd php-#{version} && make && make install)
  EOF
  not_if "php -v | grep #{version}"
end

directory node['php']['conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

directory node['php']['ext_conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "#{node['php']['ext_conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end
