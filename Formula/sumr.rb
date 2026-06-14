class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.2"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.2/sumr-darwin-arm64.tar.gz"
      sha256 "2e5e1dcd464d371a6cc1a3f5feb83e16c1ada1fd7021166163ced5f4c605fd12"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.2/sumr-darwin-x64.tar.gz"
      sha256 "70911a78cbe2d0d4b59c93da4fbde55e4eb56f7fadcc34f42160c367d510ab90"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.2/sumr-linux-arm64.tar.gz"
      sha256 "58c9e99324c8b38db355b2920490ac1631828997a9160057f651d3295c3448dd"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.2/sumr-linux-x64.tar.gz"
      sha256 "3d2eea4d5caa17d5e03b0c6bda8fe0a02201afa3ff4e530f9d9b49a7a8bc02fe"
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
