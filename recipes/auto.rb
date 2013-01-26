#
# Cookbook Name:: monit
# Recipe:: auto
#
# Copyright 2012, Alexandr Lispython
#
# All rights reserved

include_recipe "monit::default"


if node["monit"]["configs"]
  node["monit"]["configs"].each do |item|
    monitconf item[:name] do
      variables(item)
    end
  end
end
