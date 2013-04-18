php_pear "geoip" do
  repo :pecl
  action :install
  version node[:php][:pecl_packages][:geoip][:version]
end
