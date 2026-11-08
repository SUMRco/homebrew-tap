class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.9"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.9/sumr-darwin-arm64.tar.gz"
      sha256 "3a589c3c0c9a25b8440095967a9e4af75e852d230409c467d3689e2d164b4d9b"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.9/sumr-darwin-x64.tar.gz"
      sha256 "abee995b815be92afe8a51f3fb18d7514fada1050cd5b6da348f359fd7266c9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.9/sumr-linux-arm64.tar.gz"
      sha256 "b1ca32749bfa7bc039e91cf6a5c40e98c499b1f9862cf6c4fc10d7b5b9f6f1a3"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.9/sumr-linux-x64.tar.gz"
      sha256 "a46bfdb3a1ff41e408d8c87a11e46446add1e288df53d4e8be82056136d501f2"
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
