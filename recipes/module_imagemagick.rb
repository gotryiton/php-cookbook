# %w[ imagemagick php5-imagick ].each do |pkg|
#   package pkg
# end

package "imagemagick"

dotdeb_package "php5-imagick" do
  action :upgrade
end
