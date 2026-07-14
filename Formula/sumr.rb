class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.8"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.8/sumr-darwin-arm64.tar.gz"
      sha256 "812a0f0c65891cc552c5b053e16cbb19e467b61001ed240d374ccd28ced6c5d7"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.8/sumr-darwin-x64.tar.gz"
      sha256 "4155e3f3424b948d92eaeaaed0591ba613e8d79223497d6a69d63e0fcce2e888"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.8/sumr-linux-arm64.tar.gz"
      sha256 "e26bfbbf4c4bcff00bf39c07386ea171423c8d6a6b26151a2abf5317cf3deb41"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.8/sumr-linux-x64.tar.gz"
      sha256 "d845ff3917a8fd09a949c1b5b0dad64f3eac0e9c3bd3e749d980d73c29958481"
    end
  end

  def install
    bin.install Dir["sumr-*"][0] => "sumr"

    (bin/"_sumr_cli").write <<~SH
      #!/bin/bash
      exec "#{bin}/sumr" ""
    SH

    (bin/"_sumr").write <<~SH
      #!/bin/bash
      "#{bin}/_sumr_cli" ""
      _sumr_rc=0
      return $_sumr_rc 2>/dev/null || exit $_sumr_rc
    SH

    chmod 0755, bin/"_sumr_cli"
    chmod 0755, bin/"_sumr"
  end

  test do
    system "#{bin}/sumr", "--version"
    system "#{bin}/_sumr", "--version"
  end
end
