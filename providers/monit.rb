#
# Cookbook Name:: monit
# Provider:: monit
#
# Copyright 2013, Alexandr Lispython
#
# All rights reserved

require 'chef/mixin/shell_out'
require 'chef/provider/service'
require 'chef/provider/service/simple'
require 'chef/mixin/command'



# class Chef
#   class Provider
#     class Service
#       class Monit < Chef::Provider::Service

include Chef::Mixin::ShellOut

def initialize(new_resource, run_context)
  super
  @init_command = node["monit"]["script"]
end


action :start do
  if @new_resource.start_command
    super
  else
    shell_out!("#{default_init_command} start #{new_resource.service_name}")
  end
end

action :stop do
  if @new_resource.stop_command
    super
  else
    shell_out!("#{default_init_command} stop")
  end
end

action :restart do
  if @new_resource.restart_command
    super
  elsif @new_resource.supports[:restart]
    shell_out!("#{default_init_command} restart #{new_resource.service_name}")
  end
end

action :enable do
  if @new_resource.restart_command
    super
  elsif @new_resource.supports[:restart]
    shell_out!("#{default_init_command} monitor #{new_resource.service_name}")
  end
end

def default_init_command
  return @init_command
end
# def reload_service
#   if @new_resource.reload_command
#     super
#   elsif @new_resource.supports[:reload]
#     shell_out!("#{default_init_command} reload")
#   end
# end
#       end
#     end
#   end
# end
