package "imagemagick" do
  action :install
end

package "libmagickwand-dev" do
  action :install
end

php_pear "imagick" do
  action :install
  version node[:php][:pecl_packages][:imagick][:version]
end
