platform "el-7-ppc64" do |plat|
  # Note: This is a community-maintained platform. It is not tested in Puppet's
  # CI pipelines, and does not receive official releases.
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  # Currently unavailable - uncomment if/when puppet adds support for this
  # internally.
  #plat.add_build_repository "http://pl-build-tools.delivery.puppetlabs.net/yum/el/7/ppc64/pl-build-tools-ppc64.repo"
  #plat.add_build_repository "http://pl-build-tools.delivery.puppetlabs.net/yum/el/7/x86_64/pl-build-tools-x86_64.repo"
  plat.provision_with "yum install --assumeyes autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.install_build_dependencies_with "yum install --assumeyes"
  plat.cross_compiled true
  plat.vmpooler_template "redhat-7-x86_64"
end
