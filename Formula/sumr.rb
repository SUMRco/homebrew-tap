class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.5.0"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.5.0/sumr-darwin-arm64.tar.gz"
      sha256 "8acd0c31915c5917209a528510ba406bca88a497ef6c74d9905e921cb425fe72"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.5.0/sumr-darwin-x64.tar.gz"
      sha256 "ef21e4fa05e9d0a8ac86287eb62fcb454cf22c510bfe689638b6a5c6c028f7c9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.5.0/sumr-linux-arm64.tar.gz"
      sha256 "bd784b73132614616b43b47bf6d9737f13d301397630a01a59dff6be5c3bbc87"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.5.0/sumr-linux-x64.tar.gz"
      sha256 "2b81e01208ddcd4459c88d3e84140624aef912bc0a20b378efcf963d8172ddd1"
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
