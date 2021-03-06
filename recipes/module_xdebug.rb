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

pack = value_for_platform(
  [ "centos", "redhat", "fedora", "suse" ] => {
    "default" => "php-xdebug"
  },
  "default" => "php5-xdebug"
)

dotdeb_package pack do
  action :upgrade
end

template value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "/etc/xdebug.ini"}, "default" => "/etc/php5/conf.d/20-xdebug.ini") do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode 0644
  only_if { File.directory?("/etc/php5/conf.d/") }
end
