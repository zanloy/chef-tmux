#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package node[:tmux][:package]

template node[:tmux][:config_file] do
  source 'tmux.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables({
    prefix_key: node[:tmux][:prefix_key],
    vi_mode_keys: node[:tmux][:vi_mode_keys],
    clock: node[:tmux][:clock],
    osfamily: node[:platform],
  })
end
