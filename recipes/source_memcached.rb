include_recipe "libmemcached"

php_pear "memcached" do
  action :install
  version node[:php][:pecl_packages][:memcached][:version]
end
