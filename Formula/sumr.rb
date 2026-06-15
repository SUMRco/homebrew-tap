class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.5"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.5/sumr-darwin-arm64.tar.gz"
      sha256 "02162567d21f4555a8747e73052bb58862c6c8fbe9f12ce4e23249a9de9f19f0"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.5/sumr-darwin-x64.tar.gz"
      sha256 "312be3302c13bb33e4b5b4c2c53377aa1198e3eaa43fd318caeb812a3c452467"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.5/sumr-linux-arm64.tar.gz"
      sha256 "6f60d435c8274f55aafc4cabc742a29d167c8a28563f301f24eac7aa928bae40"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.5/sumr-linux-x64.tar.gz"
      sha256 "6370802f34589e778fceb02b01783b3a1e361c2c4767b13c4a94dd980f800e29"
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
