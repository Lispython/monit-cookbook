
default["monit"]["logfile"] = "/var/log/monit"
default["monit"]["use_syslog"]        = "true"
default["monit"]["idfile"] = "/var/.monit.id"
default["monit"]["statefile"] = "/var/.monit.state"
default["monit"]["daemon"] = "60"
default["monit"]["daemon_start_delay"] = "240"

default["monit"]["configs"] = Array.new

default["monit"]["alert_email"] = nil
default["monit"]["alert_email_timeout"] = nil


default["monit"]["web_interface"] = {
  "enable"  => false,
  "port"    => 2812,
  "address" => "localhost",
  "allow"   => ["localhost", "username:password"]
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
