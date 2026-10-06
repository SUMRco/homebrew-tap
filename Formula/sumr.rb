class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.7"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.7/sumr-darwin-arm64.tar.gz"
      sha256 "dbcd3db348ba3700734f220c6ed75358d136c416f4e7613768648914258baf49"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.7/sumr-darwin-x64.tar.gz"
      sha256 "157a49c3235c6c8f95b38bc27c45aa2b17a51a60bc4069bccee0da4fb8f65656"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.7/sumr-linux-arm64.tar.gz"
      sha256 "2227d6bb72001617469130a9792b94e022c4e71a15bf902571fbc0d957716323"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.7/sumr-linux-x64.tar.gz"
      sha256 "a12e1424c6caa6f7a0e65945541944b50f6e970372a082e065bcd5c8531ba7ea"
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
