# adds the dotdeb apt repository to sources
include_recipe "dotdeb"

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => %w{ php54 php54-devel php54-cli php-pear }
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-cgi php5 php5-dev php5-cli php-pear }
  },
  "default" => %w{ php5-cgi php5 php5-dev php5-cli php-pear }
)

pkgs.each do |pkg|
  dotdeb_package pkg do
    action :upgrade
  end
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

if node[:platform] == "ubuntu" && node[:lsb][:release]
	cookbook_file "/etc/cron.d/php5" do
	  source "11.10.php5.cron"
	  owner "root"
	  group "root"
	  mode "0644"
	end
end