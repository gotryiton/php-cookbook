
php_pear "apc" do
  action :install
  version node[:php][:pecl_packages][:apc][:version]
  directives(:shm_size => "128M", :enable_cli => 0)
end
