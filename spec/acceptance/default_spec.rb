# Encoding: utf-8
require_relative 'spec_windowshelper'

# hardcoded for 2012 R2
describe command('wmic qfe | findstr KB3134758') do
  its(:stdout) { should match(/KB3134758/) }
end

describe file('C:/Windows/Temp/wmf_5.0.msu') do
  it { should be_file }
end
