git "/home/vagrant/.emacs.d" do
  repository node.emacs.config.repository
  action :checkout
end
