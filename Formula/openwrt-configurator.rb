# Rendered by packaging/homebrew/render.sh for each release and pushed to the
# jasrusable/homebrew-tap repository. Do not edit the rendered copy there.
class OpenwrtConfigurator < Formula
  desc "Provision OpenWrt devices from one JSON network config"
  homepage "https://github.com/jasrusable/openwrt-configurator"
  url "https://github.com/jasrusable/openwrt-configurator/releases/download/v0.1.0/openwrt-configurator.mjs"
  version "0.1.0"
  sha256 "b28398034c4b6f63b3552cda8bd8f62e973dae2922348b090eb7755259051953"
  license "ISC"

  depends_on "quickjs"

  def install
    libexec.install "openwrt-configurator.mjs"
    (bin/"openwrt-configurator").write <<~SH
      #!/bin/sh
      exec "#{Formula["quickjs"].opt_bin}/qjs" --module "#{libexec}/openwrt-configurator.mjs" "$@"
    SH
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/openwrt-configurator --version").strip
  end
end
