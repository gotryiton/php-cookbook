package "php5-cgi" do
  action :upgrade
end

package "php5-fpm" do
  action :upgrade
end

case node['platform']
when "debian", "ubuntu"
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
end

service "php5-fpm" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

service "php5-fpm" do
  subscribes :restart, resources(
      :template => "www.conf",
      :template => "cgi_php.ini",
      :template => "fpm_php.ini",
      :template => "php-fpm.conf"
    ), :delayed
end

monit_watch "php-fpm"
