#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2012, Alexandr Lispython
#
# All rights reserved


package "monit"

cookbook_file node['monit']['defaultfile'] do
  source "monit"
  mode "0644"
end

template "#{node["monit"]["main_config_path"]}" do
  owner  "root"
  group  "root"
  mode   "0700"
  source "monitrc.erb"
end

service "monit" do
  supports :restart => true, :start => true, :stop => true
  action [:enable, :restart]
end
