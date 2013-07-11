# Author:: Tom Planer (<tplaner@gmail.com>)
# Cookbook Name:: mailcatcher
# Recipe:: default
#

include_recipe "build-essential"

package "libsqlite3-dev"

gem_package "mailcatcher"

# extracted from: https://github.com/r8/vagrant-lamp

# Get eth1 ip
eth1_ip = node[:network][:interfaces][:eth1][:addresses].select{|key,val| val[:family] == 'inet'}.flatten[0]

# Setup MailCatcher
bash "mailcatcher" do
  code "mailcatcher --http-ip #{eth1_ip} --smtp-port 25"
  not_if "ps ax | grep -v grep | grep mailcatcher";
end