maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs emacs"
version           "0.8.2"

recipe "emacs", "Installs Emacs"
recipe "emacs:source24", "Installs Emacs 24 from source"
recipe "emacs:config", "Clones .emacs.d from specified git repo"

%w{ ubuntu debian redhat centos scientific fedora freebsd }.each do |os|
  supports os
end
