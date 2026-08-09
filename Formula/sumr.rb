class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.5"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.5/sumr-darwin-arm64.tar.gz"
      sha256 "d3763155935e7839066dc914f6a8060ea3afe86fc4b7f65a0cb4d4eae44e35e6"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.5/sumr-darwin-x64.tar.gz"
      sha256 "54af6b646e794414c05687b1d8c520408df71e9fe2a6826825faf308b2d44b38"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.5/sumr-linux-arm64.tar.gz"
      sha256 "58ed41b13f306200910ab1c5bd73de9d6d182cf2a6316280672744dcdc0c9dca"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.5/sumr-linux-x64.tar.gz"
      sha256 "be7e4207cf1adb6b6edbd2462370c5bc03c6f474fa7407687bc4746b68ab49df"
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
