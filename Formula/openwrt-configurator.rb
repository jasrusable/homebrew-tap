# Rendered by packaging/homebrew/render.sh for each release and pushed to the
# jasrusable/homebrew-tap repository. Do not edit the rendered copy there.
class OpenwrtConfigurator < Formula
  desc "Describe your network once; configure every OpenWrt router and access point"
  homepage "https://github.com/jasrusable/openwrt-configurator"
  url "https://github.com/jasrusable/openwrt-configurator/releases/download/v0.1.2/openwrt-configurator-node.tar.gz"
  version "0.1.2"
  sha256 "a6774b624fc2d720606133770c5d61cd181017461851ed1ba537653f407df7ac"
  license "AGPL-3.0-or-later"

  # The Node build, as QuickJS cannot listen on a port for the web UI.
  depends_on "node"

  def install
    # bin/openwrt-configurator.js finds the web UI beside it, at ../ui.
    libexec.install "bin", "ui"
    (bin/"openwrt-configurator").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/bin/openwrt-configurator.js" "$@"
    SH
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/openwrt-configurator --version").strip
    assert_match "intent-file", shell_output("#{bin}/openwrt-configurator ui --help")
  end
end
