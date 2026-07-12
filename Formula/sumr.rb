class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.7"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.7/sumr-darwin-arm64.tar.gz"
      sha256 "4db23796f8e169df203870dcf3c6ffaf129f317e6b2aaccc878fc209de23fd45"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.7/sumr-darwin-x64.tar.gz"
      sha256 "0ab5981dbeac42f40742d3880b70a9408fe9c4ed8efe71f12d22c9d2ca78417c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.7/sumr-linux-arm64.tar.gz"
      sha256 "3890464f4d0bc185a064ec546ae8a8a218134bf702314a2f4ebe6ad2720c3882"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.7/sumr-linux-x64.tar.gz"
      sha256 "6a4852ff7e185723568c4050aaf445d493f99d06b1f0aae40d0175a45628d7ff"
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
