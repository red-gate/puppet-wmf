source 'https://rubygems.org'

gem 'puppet-lint'

gem 'test-kitchen', '~> 1'
gem 'kitchen-puppet', '~> 1'

# We need this PR in to work with vagrant 1.8.6 on windows :sweat:
# https://github.com/test-kitchen/kitchen-vagrant/pull/241
gem 'kitchen-vagrant', :github => 'test-kitchen/kitchen-vagrant', :ref => 'b20ee505220fd75201aae3eaedd1520c6d0cbf82'

# needed by the vagrant-winrm vagrant plugin which is needed by kitchen-vagrant in order to be able to use winrm
gem 'winrm-fs', '~> 1'
gem 'winrm-elevated', '~> 1'

# We use serverspec to test the state of our servers
gem 'serverspec', '~> 2'

# We use rake as our build engine
gem 'rake', '~> 11'
# This gem tells us how long each rake task takes.
gem 'rake-performance'

# We use r10k to download our puppet modules.
# We do use our own fork which contains a fix/workaround for SSL validation on windows.
gem 'r10k', :github => 'red-gate/r10k', :branch => '2.0.x'
