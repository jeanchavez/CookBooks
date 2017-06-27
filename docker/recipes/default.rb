#
# Cookbook:: docker
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# Author: jeancarloschavez@gmail.com

case node['platform_family']
when "rhel"
	
	execute "install_docker" do
		command "curl -fsSL https://get.docker.com/ | sh"
	end

	service "docker" do
		action [:start, :enable]
	end
	
	Chef::Log.info("Docker has been installed")
else
	Chef::Log.warn("`#{node['platform_family']}' is not supported!")
	raise "`#{node['platform_family']}' is not supported!"
end

