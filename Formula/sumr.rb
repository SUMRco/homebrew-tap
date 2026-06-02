class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.2.1"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.2.1/sumr-darwin-arm64.tar.gz"
      sha256 "71bb215c22ad82ab2af44b11c07591630fbacda5c79f1228ef8300a10dd6bfd1"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.2.1/sumr-darwin-x64.tar.gz"
      sha256 "b2fb697aba263dd9109d40c803dcb75ae2c34268fd08ebb651978caf2061e0cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.2.1/sumr-linux-arm64.tar.gz"
      sha256 "c9270ba2f6889ae86b3915659f56df98de1bba61a85c8d904a977301f0eb4e7c"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.2.1/sumr-linux-x64.tar.gz"
      sha256 "ef8d5eafc2bc1bc9f3f340e17be588e75c5bead7cd95b4f44045cfd8abf178f2"
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
