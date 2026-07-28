class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.3"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.3/sumr-darwin-arm64.tar.gz"
      sha256 "3dbb8e314632796f9af3b0a9cbaa3188d094ef0bd2277a155363b1043fa9859f"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.3/sumr-darwin-x64.tar.gz"
      sha256 "a4e55521b25391db74468e10a542ac7bba5f3b6e7c064afa403a957160f588b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.3/sumr-linux-arm64.tar.gz"
      sha256 "ef34bbb090a91cd5041585f8762db659fef8d3cde8a0eb0df7e858ae9b67e680"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.3/sumr-linux-x64.tar.gz"
      sha256 "2ae29a1105b5e17f75a93d8f0e34b8d7627e73db075364dd6bf69175cca4541e"
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
