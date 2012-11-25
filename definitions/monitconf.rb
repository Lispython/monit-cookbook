define :monitconf, :name => nil, :variables => {} do
  Chef::Log.info("Making monit config for: #{params[:name]}")

  template "#{node[:monit][:includes_dir]}/#{params[:name]}.conf" do
    owner "root"
    group "root"
    mode  "0644"
    source "conf.erb"
    variables params[:variables]
    #notifies :restart, resources(:service => "monit")
    action :create
  end
end
