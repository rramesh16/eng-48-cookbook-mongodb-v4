#
# Cookbook:: mongodb-v4
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
execute 'mongodb keyserver' do
  command 'wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -'
  action :run
end

execute 'mongodb key' do
  command 'echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list'
  action :run
end

include_recipe 'apt'
apt_update

execute 'mongodb' do
  command 'sudo apt-get install -y mongodb-org=4.2.2 mongodb-org-server=4.2.2 mongodb-org-shell=4.2.2 mongodb-org-mongos=4.2.2 mongodb-org-tools=4.2.2'
  action :run
end

execute 'restart mongodb' do
  command 'sudo systemctl restart mongod'
  action :run
end

execute 'enable mongodb' do
  command 'sudo systemctl enable mongod'
  action :run
end
