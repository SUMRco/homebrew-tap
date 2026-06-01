class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.1.1"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.1.1/sumr-darwin-arm64.tar.gz"
      sha256 "da396fa487b07f3b946ab5e2c93f1afebfadbb6c78cc40f786d343eca0eb69c0"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.1.1/sumr-darwin-x64.tar.gz"
      sha256 "3784f80dfe612018271c7384fe86386a9afbd426a1e5d40f766d45a7005f951f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.1.1/sumr-linux-arm64.tar.gz"
      sha256 "9b1c8aaa8cd276de9685298c5ecda45c9309a39d2873c61189acae800c4aff6f"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.1.1/sumr-linux-x64.tar.gz"
      sha256 "8f2adb5230ed0639c65bdfaffa2246583be4f883d0958bc912b057b4d7842897"
    end
  end

  def install
    bin.install Dir["sumr-*"][0] => "sumr"

    (bin/"_sumr_cli").write <<~SH
      #!/bin/bash
      exec "#{bin}/sumr" "$@"
    SH

    (bin/"_sumr").write <<~SH
      #!/bin/bash
      "#{bin}/_sumr_cli" "$@"
      _sumr_rc=$?
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
