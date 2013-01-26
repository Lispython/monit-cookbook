action :create do
  Chef::Log.info("Create monit config for #{new_resource}")

  config = new_resource.config
  config["name"] = new_resource.name
  template = new_resource.template || node["monit"]["template"]

  template "#{node[:monit][:includes_dir]}/#{new_resource.name}.conf" do
    owner "root"
    group "root"
    mode "0644"
    source template
    variables config
    notifies :restart, resources(:service => "monit"), :delayed
    action :create
    if new_resource.cookbook
      cookbook new_resource.cookbook
    else
      cookbook "monit"
    end
  end

  new_resource.updated_by_last_action(true)
end


action :delete do
  Chef::Log.info("Create monit config for #{new_resource}")
  path = "#{node["monit"]["includes_dir"]}/#{new_resource.name}.conf"
  execute "delete #{path}" do
    command "rm -f #{path1}"
  end

  new_resource.updated_by_last_action(true)
end
