#
# Cookbook Name:: graylog2
# Recipe:: elasticsearch
#
# Copyright 2013, Christian Trabold
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Download the elasticsearch dpkg and register the service

remote_file "elasticsearch_dpkg" do
  path "#{node[:graylog2][:basedir]}/rel/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
  source "#{node[:graylog2][:elasticsearch][:repo]}/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
  action :create_if_missing
end

dpkg_package "elasticsearch" do
  source "#{node[:graylog2][:basedir]}/rel/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
  version node[:graylog2][:elasticsearch][:version]
  action :install
end

# Service resource
service "elasticsearch" do
  supports :restart => true
  action [:enable, :start]
end
