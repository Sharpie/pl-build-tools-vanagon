platform "debian-9-armhf" do |plat|
  plat.servicedir "/lib/systemd/system"
  plat.defaultdir "/etc/default"
  plat.servicetype "systemd"
  plat.codename "stretch"

  # FIXME: This should be configurable.
  plat.add_build_repository "https://dl.bintray.com/sharpie/pl-build-tools-deb/sharpie-build-tools-release-#{plat.get_codename}.deb"
  plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends build-essential devscripts make quilt pkg-config debhelper rsync fakeroot"
  plat.install_build_dependencies_with "DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends "

  plat.vmpooler_template "debian-9-x86_64"
  # NOTE: Bring your own image. The image is expected to satisfy the following
  #       conditions:
  #
  #         - Runs SystemD
  #         - Runs SSHD under SystemD
  #           - SSHD allows pubkey access to the root user via a
  #             key set by the VANAGON_SSH_KEY environment variable.
  plat.docker_image ENV['VANAGON_DOCKER_IMAGE']
  plat.ssh_port 4222
  plat.docker_run_args ['--tmpfs=/tmp:exec',
                        '--tmpfs=/run',
                        '--volume=/sys/fs/cgroup:/sys/fs/cgroup:ro',
                        # The SystemD version used by Debian 9 is old
                        # enough that it requires some elevated privilages.
                        '--cap-add=SYS_ADMIN']

  plat.cross_compiled "true"
  plat.output_dir File.join("deb", plat.get_codename)
end
