name "monit"
maintainer       "Alexandr Lispython"
maintainer_email "alex@obout.ru"
license          "MIT"
description      "Installs/Configures monit"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.4"


%w{ubuntu debian}.each do |os|
  supports os
end
