#
# Cookbook Name:: mercury
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#include_recipe 'selinux::permissive'
#include_recipe 'mercury::iptables'
include_recipe 'mercury::web_user'
include_recipe 'mercury::web'
include_recipe 'mercury::mysql'
