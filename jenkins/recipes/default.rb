#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# Author: jeancarloschavez@gmail.com


case node['platform_family']
when "rhel"
	package "wget"

	package "java" do
		action :remove
	end

	execute "get_java_rpm" do
		command "wget --no-cookies --no-check-certificate --header 'Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie' -P /opt 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz'"
	end

	execute "tar_java_rpm_file" do
		command "tar -C /opt -zxvf /opt/jdk-8u131-linux-x64.tar.gz"
	end

	execute "install_java_rpm" do
		command "alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2"
	end

	execute "set_java" do
		command "alternatives --set java /opt/jdk1.8.0_131/bin/java"
	end

	Chef::Log.info('Java has been installed')

	execute "jenkins_repo" do
		command "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo"
	end

	execute "jenkins_key" do
		command "rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
	end

	package "jenkins" do
		action :install
	end


	service "jenkins" do
		action [:start, :enable, :restart]
	end

	execute "jenkins_config" do
		command "chkconfig jenkins on"
	end

	execute "firewall_add_port" do
		command "firewall-cmd --zone=public --add-port=8080/tcp --permanent"
	end

	execute "firewall_config" do
		command "firewall-cmd --zone=public --add-service=http --permanent"
	end

	execute "firewall_reload" do
		command "firewall-cmd --reload"
	end

else
	raise "`#{node['platform_family']}' is not supported!"
end
