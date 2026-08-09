class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.4"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.4/sumr-darwin-arm64.tar.gz"
      sha256 "e696ac7c772bcfbb8ef7db299d9be17e69a74b4283e6767ee194e99f28226689"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.4/sumr-darwin-x64.tar.gz"
      sha256 "d8fd56ec9e36cd41b4879af33141ba671a9120fd3e70467a1c60ae25fd200d87"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.4/sumr-linux-arm64.tar.gz"
      sha256 "61f2e22c8c5b51ce1aeed7fea30d6cd0e084772948c760493b2d7682693d9c2d"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.4/sumr-linux-x64.tar.gz"
      sha256 "edb59a057e52616c0acfe18756e006849643f2870c83f6868fd6caa3a8de3014"
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
