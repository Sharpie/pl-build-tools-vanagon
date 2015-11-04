component "m4" do |pkg, settings, platform|
  pkg.version "1.4.17"
  pkg.md5sum "a5e9954b1dae036762f7b13673a2cf76"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{pkg.get_name}-#{pkg.get_version}.tar.gz"

  if platform.is_aix?
    pkg.build_requires "http://osmirror.delivery.puppetlabs.net/AIX_MIRROR/make-3.80-1.aix5.1.ppc.rpm"
    pkg.build_requires "http://pl-build-tools.delivery.puppetlabs.net/aix/#{platform.os_version}/ppc/pl-gcc-5.2.0-1.aix#{platform.os_version}.ppc.rpm"
    pkg.environment "CC" => "/opt/pl-build-tools/bin/gcc"
  else
    pkg.build_requires "gcc"
    pkg.build_requires "make"
  end

  if platform.name =~ /el-4/
    pkg.build_requires "pl-tar"
  end

  pkg.configure do
    [ "./configure --prefix=#{settings[:prefix]}" ]
  end

  pkg.build do
    [
      "#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"
    ]
  end

  pkg.install do
    [
      "#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install"
    ]
  end

end
