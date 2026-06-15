class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.4"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.4/sumr-darwin-arm64.tar.gz"
      sha256 "76a84003f83574b0fb534061f63c4b033946681e138728b8c04168f8fde08a2c"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.4/sumr-darwin-x64.tar.gz"
      sha256 "93074df9a8903e9c364bf10086bdad2aa576125bbe5256e6b64024b31cdd8500"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.4/sumr-linux-arm64.tar.gz"
      sha256 "1222ccd4c2de011e78d790af904f6493373277efe9d654711302bba72012aaef"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.4/sumr-linux-x64.tar.gz"
      sha256 "efd8b91a9fa98662a649eb03b4d27851bd7fedbd82093fbb7ebf41a99de2f827"
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
