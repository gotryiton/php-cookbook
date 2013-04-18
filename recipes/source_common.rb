
include_recipe "build-essential"
include_recipe "mysql::client"
include_recipe "libxml"
include_recipe "libssl"

case node[:platform]
when "ubuntu", "debian"
  %w{libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libmcrypt-dev libpng12-dev libt1-dev libmhash-dev libexpat1-dev libicu-dev libtidy-dev re2c lemon}.each do |pkg|
    package(pkg) { action :install }
  end

  link "/usr/lib/libpng.so" do
    to "/usr/lib/#{node.php.arch}-linux-gnu/libpng.so"
  end

  if node[:platform_version].to_f >= 12.04
    link "/usr/lib/libmysqlclient.so" do
      to "/usr/lib/#{node.php.arch}-linux-gnu/libmysqlclient.so"
    end
  end

  if node[:platform_version].to_f >= 11.10
    package "libltdl-dev" do
      action :install
    end

    # on 11.10+, we also have to symlink libjpeg and a bunch of other libraries
    # because of the 32-bit/64-bit library directory separation. MK.
    link "/usr/lib/libjpeg.so" do
      to "/usr/lib/#{node.php.arch}-linux-gnu/libjpeg.so"
    end

    link "/usr/lib/libstdc++.so.6" do
      to "/usr/lib/#{node.php.arch}-linux-gnu//usr/lib/libstdc++.so.6"
    end
  end
end
