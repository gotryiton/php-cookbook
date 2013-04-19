#
# Author::  Dustin Currie (<dustin@onlinedesert.com.com>)
# Cookbook Name:: php
# Recipe:: module_gd
#
# Copyright 2010, Dustin Currie
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# sudo easy_install readline
# http://github.com/facebook/phpsh/tarball/master

# python setup.py build
# sudo python setup.py install
# phpsh

%w{ libncurses5-dev python-setuptools python2.7-dev}.each do |package_name|
  package package_name do
    action :install
  end
end

phpsh_version = node[:php][:phpsh][:version]

remote_file "#{Chef::Config[:file_cache_path]}/phpsh.tar.gz" do
  source node[:php][:phpsh][:url]
  checksum node[:php][:phpsh][:checksum]
  mode "0644"
  not_if "phpsh --version | grep #{phpsh_version}"
end

bash "install readline" do
  code <<-EOF
  easy_install readline
  EOF
  user "root"
  not_if "phpsh --version | grep #{phpsh_version}"
end

bash "tar phpsh" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOF
  tar xf phpsh.tar.gz
  EOF
  user "root"
  not_if "phpsh --version | grep #{phpsh_version}"
end

bash "install phpsh" do
  cwd "#{Chef::Config[:file_cache_path]}/gotryiton-phpsh-38e70ca"
  code <<-EOF
  python setup.by build
  sudo python setup.py install
  EOF
  user "root"
  not_if "phpsh --version | grep #{phpsh_version}"
end

template "/etc/phpsh/rc.php" do
  owner "root"
  group "root"
  mode "0644"
  source "rc.php.erb"
end
