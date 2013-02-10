define :monitconf,
       :name => nil,
       :variables => {},
       :template => nil,
       :monit_action => "monitor" do
  Chef::Log.info("Making monit config for: #{params[:name]}")

  if params[:template]
    template_name = params[:template]
  else
    template_name = "conf.erb"
  end



  template "#{node[:monit][:includes_dir]}/#{params[:name]}.conf" do
    owner "root"
    group "root"
    mode  "0644"
    source template_name
    variables params[:variables]
    notifies :reload, resources(:service => "monit"), :delayed
    action :create
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "monit"
    end
  end

end
