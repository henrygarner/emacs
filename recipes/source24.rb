version = "emacs-24.1"
basedir = Chef::Config[:file_cache_path]
srcdir  = "#{basedir}/#{version}"

%w{ wget
    build-essential
    texinfo
    autoconf
    libncurses5-dev }.each do |prereq|
      package prereq
end

bash "download emacs24" do
  cwd basedir
  creates srcdir
  code <<-EOH
  wget http://ftp.gnu.org/gnu/emacs/#{version}.tar.gz
  tar -zxf #{version}.tar.gz
  EOH
end

bash "build emacs24" do
  cwd srcdir
  creates "#{srcdir}/src/emacs"
  code <<-EOH
    ./configure --without-x && \
    make bootstrap && \
    make 2>&1 >| make-#{node.name}-#{node['ohai_time']}
  EOH
end

execute "install emacs24" do
  cwd srcdir
  command "make install 2>&1 >| make-#{node.name}-#{node['ohai_time']}"
  creates "/usr/local/bin/emacs"
  only_if "#{srcdir}/src/emacs --version"
end

git "/home/vagrant/.emacs.d" do
  repository "git://github.com/overtone/emacs-live.git"
  action :checkout
end
