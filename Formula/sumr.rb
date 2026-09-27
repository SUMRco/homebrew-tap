class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.6"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.6/sumr-darwin-arm64.tar.gz"
      sha256 "4b11cfec8e3057ac91b5c9a6c7797f2ece8cb2e79ca1ab83521df584c17f9ff8"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.6/sumr-darwin-x64.tar.gz"
      sha256 "8efab87ff0bc2107ff20e8812de8c2cb97f5a54cf563cb7ca79859335e38dccc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.6/sumr-linux-arm64.tar.gz"
      sha256 "27f9c7b2e1f07fe79198a52534c5fb240b4c1b571bd3d2f26fb9f3689c1e8c58"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.6/sumr-linux-x64.tar.gz"
      sha256 "f2acebba45b4ab066d150f6f024c47af3c3b1d6246facedbe4d3e53d86fe2825"
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
