require 'spec_helper'

property['common_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
property['common_users'].each do |user|
  describe user(user['name']) do
    it { should exist }
    it { should belong_to_group 'adm' } if user.key?('admin') && user['admin']
  end
end

describe package('ufw') do
  it { should be_installed }
end

describe package('fail2ban') do
  it { should be_installed }
end

describe file('/etc/fail2ban/jail.local') do
  it { should exist }
  it { should be_file }
end

describe package('etckeeper') do
  it { should be_installed }
end

describe service('ufw') do
  it { should be_enabled }
  it { should be_running }
end
describe service('fail2ban') do
  it { should be_enabled }
  it { should be_running }
end
