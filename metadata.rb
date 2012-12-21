maintainer       "Vasily Mikhaylichenko"
maintainer_email "vasily@locomote.com"
license          "BSD"
description      "Configures time zone"
version          "0.1"

%w{ubuntu debian redhat centos scientific amazon}.each do |os|
  supports os
end
