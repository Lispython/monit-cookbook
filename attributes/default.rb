
default["monit"]["logfile"] = "/var/log/monit"
default["monit"]["use_syslog"] = "true"
default["monit"]["libdir"] = "/var/lib/monit"
default["monit"]["idfile"] = "#{node["monit"]["libdir"]}/id"
default["monit"]["statefile"] = "#{node["monit"]["libdir"]}/state"
default["monit"]["daemon"] = "60"
default["monit"]["daemon_start_delay"] = false

default["monit"]["configs"] = Array.new

default["monit"]["alert_email"] = nil
default["monit"]["alert_email_timeout"] = nil


default["monit"]["web_interface"] = {
  "enable"  => false,
  "port"    => 2812,
  "address" => nil,
  "allow"   => ["name:pass"]
}

default["monit"]["mail"] = {
  "hostname" => "localhost",
  "port"     => 25,
  "username" => nil,
  "password" => nil,
  "from"     => "monit@$HOST",
  "subject"  => "$SERVICE $EVENT at $DATE",
  "message"  => "Monit $ACTION $SERVICE at $DATE on $HOST,\n\nDutifully,\nMonit",
  "tls"      => false,
  "timeout"  => 30
}

case platform
when "redhat","centos","fedora"
  default["monit"]["main_config_path"] = "/etc/monit.conf"
  default["monit"]["includes_dir"] = "/etc/monit.d"
else
  default["monit"]["main_config_path"] = "/etc/monit/monitrc"
  default["monit"]["includes_dir"] = "/etc/monit/conf.d"
end


default["monit"]["defaultfile"] = "/etc/default/monit"
default["monit"]["template"] = "config.erb"

case node[:platform]
when "ubuntu"
  if node[:platform_version].to_f < 11.04
    default["monit"]["script"] = "/usr/sbin/monit"
  else
    default["monit"]["script"] = "/usr/bin/monit"
  end
end


default["monit"]["eventqueue"]["on"] = true
default["monit"]["eventqueue"]["eventsdir"] = "#{node["monit"]["libdir"]}/events"
default["monit"]["eventqueue"]["slots"] = 100
