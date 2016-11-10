require 'serverspec'
require 'winrm'

set :backend, :winrm
set :os, :family => 'windows'

opts = {
  endpoint: "http://#{ENV['KITCHEN_HOSTNAME']}:#{ENV['KITCHEN_PORT']}/wsman",
  user: ENV['KITCHEN_USERNAME'],
  password: 'vagrant'
}
Specinfra.configuration.winrm = WinRM::Connection.new(opts)
