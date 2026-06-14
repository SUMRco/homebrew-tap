class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.1"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.1/sumr-darwin-arm64.tar.gz"
      sha256 "558671c9f57adedb2b39929e5a20bd907d0adf7d8944eb40931e8124791e16c4"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.1/sumr-darwin-x64.tar.gz"
      sha256 "f84a26c4c83c984b6c0cfa6df541e562c1e60bcc2984cdf64664cecd51085980"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.1/sumr-linux-arm64.tar.gz"
      sha256 "22c5296a1df4935bb0ef9db8763a5bdf4fb1aa5804d9c6922dee5f28f5b2eede"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.1/sumr-linux-x64.tar.gz"
      sha256 "278bc898277d0eeb492958ae7591306f2a66d20f927f10167788047e9d8facaa"
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
