#
#
# Copyright 2011, Opscode, Inc.
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

lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib' : 'lib'

default['php']['install_method'] = 'package'

case node["platform"]
when "centos", "redhat", "fedora"
  default['php']['conf_dir']      = '/etc'
  default['php']['ext_conf_dir']  = '/etc/php.d'
  default['php']['fpm_user']      = 'nobody'
  default['php']['fpm_group']     = 'nobody'
  default['php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
  default['php']['fpm']['src_binary'] = "/usr/sbin/php5-fpm"
  default['php']['fpm']['conf_dir'] = "/etc/php5/fpm"
when "debian", "ubuntu"
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
  default['php']['etc_dir']       = '/etc/php5'
  default['php']['fpm']['src_binary'] = "/usr/sbin/php5-fpm"
  default['php']['fpm']['conf_dir'] = "/etc/php5/fpm"
else
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
  default['php']['fpm']['src_binary'] = "/usr/sbin/php5-fpm"
  default['php']['fpm']['conf_dir'] = "/etc/php5/fpm"
end

# ini attributes
default['php']['display_errors']  = 'Off'
default['php']['html_errors']     = 'On'
default['php']['timezone']     = 'America/New_York'

default['php']['url'] = 'http://us.php.net/distributions'
default['php']['version'] = '5.3.8'
default['php']['checksum'] = '704cd414a0565d905e1074ffdc1fadfb'
default['php']['prefix_dir'] = '/usr/local'

default['php']['configure_options'] = %W{--prefix=#{php['prefix_dir']}
                                          --with-libdir=#{lib_dir}
                                          --with-config-file-path=#{php['conf_dir']}
                                          --with-config-file-scan-dir=#{php['ext_conf_dir']}
                                          --with-pear
                                          --enable-fpm
                                          --enable-pcntl
                                          --with-fpm-user=#{php['fpm_user']}
                                          --with-fpm-group=#{php['fpm_group']}
                                          --with-zlib
                                          --with-openssl
                                          --with-kerberos
                                          --with-bz2
                                          --with-curl
                                          --enable-ftp
                                          --enable-zip
                                          --enable-exif
                                          --with-gd
                                          --enable-gd-native-ttf
                                          --with-gettext
                                          --with-gmp
                                          --with-mhash
                                          --with-iconv
                                          --with-imap
                                          --with-imap-ssl
                                          --enable-sockets
                                          --enable-soap
                                          --with-xmlrpc
                                          --with-libevent-dir
                                          --with-mcrypt
                                          --enable-mbstring
                                          --with-t1lib
                                          --with-mysql
                                          --with-mysqli=/usr/bin/mysql_config
                                          --with-mysql-sock
                                          --with-sqlite3
                                          --with-pdo-mysql
                                          --with-pdo-sqlite}

default[:php][:fpm][:max_children] = 60
default[:php][:fpm][:start_servers] = 25
default[:php][:fpm][:min_spare_servers] = 20
default[:php][:fpm][:max_spare_servers] = 30
default[:php][:fpm][:numprocs] = 2
default[:php][:fpm][:max_requests] = 200
default[:php][:fpm][:daemonize] = "yes"
default[:php][:apc][:max_file_size] = "5M"

default[:php][:arch] = kernel['machine'] =~ /x86_64/ ? "x86_64" : "i386"
default['php']['54_version'] = "5.4.10"
default['php']['54_configure_options'] = %W{--prefix=#{php['prefix_dir']}
                                          --with-libdir=#{lib_dir}
                                          --with-config-file-path=#{php['conf_dir']}
                                          --with-config-file-scan-dir=#{php['ext_conf_dir']}
                                          --with-pear
                                          --enable-fpm
                                          --enable-pcntl
                                          --with-fpm-user=#{php['fpm_user']}
                                          --with-fpm-group=#{php['fpm_group']}
                                          --with-zlib
                                          --with-openssl
                                          --with-kerberos
                                          --with-bz2
                                          --with-curl
                                          --enable-ftp
                                          --enable-zip
                                          --enable-exif
                                          --with-gd
                                          --enable-gd-native-ttf
                                          --with-gettext
                                          --with-gmp
                                          --with-mhash
                                          --with-iconv
                                          --with-imap
                                          --with-imap-ssl
                                          --enable-sockets
                                          --enable-soap
                                          --with-xmlrpc
                                          --with-mcrypt
                                          --enable-mbstring
                                          --with-t1lib
                                          --with-mysql
                                          --with-mysqli=/usr/bin/mysql_config
                                          --with-mysql-sock
                                          --with-sqlite3
                                          --with-pdo-mysql=/usr/bin/mysql_config
                                          --with-pdo-sqlite
                                          --with-readline}

default[:php][:pecl_packages] = {
  :apc => { :version => "3.1.14" },
  :memcached => { :version => "2.1.0" },
  :geoip => { :version => "1.0.8" },
  :xdebug => { :version => "2.2.1" },
  :imagick => { :version => "3.1.0RC2" }
}

default[:php][:pecl_url] = "http://pecl.php.net/get"

default[:php][:xdebug] = {
  remote_debug: false
}
