class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.0"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.0/sumr-darwin-arm64.tar.gz"
      sha256 "663b2541d6373a93daa9b286c72336081acb84d9e949a3c373c5e4072ae1cba9"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.0/sumr-darwin-x64.tar.gz"
      sha256 "1416a90dd03f6d1a7b5c8b86d001ae55ac161021c4a9d1dd6497ed8294b3a5af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.0/sumr-linux-arm64.tar.gz"
      sha256 "7e07c2a36da47bd7efe0bc61988bc04e5127c1524023bc1377b4b2e8d7a5cb9b"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.0/sumr-linux-x64.tar.gz"
      sha256 "575af38a33acbc4c97c9c40aa2a227175e7e491dd73355aa4442380453d714cc"
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
