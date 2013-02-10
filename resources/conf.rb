# -*- coding: utf-8 -*-
#
# Cookbook Name:: monit cookbook
# Resource:: conf

# Create redis configuration with instance running
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/redis-cookbook
#


actions :create, :delete

attribute :name, :kind_of => String, :name_attribute => true
attribute :config, :kind_of => Hash, :default => {}
attribute :template, :kind_of => String, :default => "cofig.erb"
attribute :cookbook, :kind_of => String, :default => nil
attribute :monit_action, :kind_of => String, :default => "start"


def initialize(*args)
  super
  @action = :create
  @provider = Chef::Provider::MonitBase
end
