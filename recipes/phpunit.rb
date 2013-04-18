include_recipe "php"

channels = %w{pear.phpunit.de components.ez.no pear.symfony-project.com}
channels.each do |chan|
  php_pear_channel chan do
    action [:discover, :update]
  end
end

php_pear "HTTP_Request2" do
  preferred_state "beta"
  action :install
end

php_pear "XML_RPC2" do
  action :install
end

php_pear "PHPUnit" do
  channel "phpunit"
  action :install
end