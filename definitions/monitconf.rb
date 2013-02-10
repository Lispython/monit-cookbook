define
       :monitconf,
       :name => nil,
       :variables => {},
       :template => nil,
       :action => :monitor do
  Chef::Log.info("Making monit config for: #{params[:name]}")

  if params[:template]
    template_name = params[:template]
  else
    template_name = "conf.erb"
  end

  bash "monitconf-#{params[:name]}" do
    user "root"
    code <<-EOH
        monit #{params[:action]} #{params[:name]}
    EOH
  end

  template "#{node[:monit][:includes_dir]}/#{params[:name]}.conf" do
    owner "root"
    group "root"
    mode  "0644"
    source template_name
    variables params[:variables]
    notifies :reload, resources(:service => "monit"), :delayed
    notifies :run, resources(:bash => "monitconf-#{params[:name]}")
    action :create
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "monit"
    end
  end


end
