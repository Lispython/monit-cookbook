#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2012, Alexandr Lispython
#
# All rights reserved


package "monit"

service "monit" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end


if node["monit"]["configs"]

  node["monit"]["configs"].each do |item|
    monitconf item[:name] do
      variables(item)
    end
  end
end

template "#{node["monit"]["main_config_path"]}" do
  owner  "root"
  group  "root"
  mode   "0700"
  source "monitrc.erb"
  notifies :restart, "service[monit]"
end
