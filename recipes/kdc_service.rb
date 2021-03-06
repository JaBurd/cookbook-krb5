#
# Cookbook Name:: krb5
# Recipe:: kdc_service
#
# Copyright © 2014 Cask Data, Inc.
# Copyright © 2018 Chris Gianelloni
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

include_recipe 'krb5::default'
include_recipe 'krb5::kdc'

service 'krb5-kdc' do
  service_name node['krb5']['kdc']['service_name']
  action node['krb5']['kdc']['service_actions']
  subscribes :restart, "template['#{node['krb5']['data_dir']}/kdc.conf']", :delayed \
    if [ *node['krb5']['kdc']['service_actions']].find { |a| /start/ =~ a }
end

service 'kprop' do
  service_name node['krb5']['kprop']['service_name']
  action node['krb5']['kprop']['service_actions']
end
