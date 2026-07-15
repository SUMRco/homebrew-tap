class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.9"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.9/sumr-darwin-arm64.tar.gz"
      sha256 "ce7c6670b0469f11f166082754208faccbe696ba944db801f05a1fc78e1e55be"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.9/sumr-darwin-x64.tar.gz"
      sha256 "090a395acd0e8893dc9bd576bb680ecdcabd77e01142b4766bb6ae61f6f9002e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.9/sumr-linux-arm64.tar.gz"
      sha256 "cd75c8c18f571c94ef609825e87a22644041a7937590e64b6151874740172ef5"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.9/sumr-linux-x64.tar.gz"
      sha256 "be6cbc960e20133ded721f71856e3ac25ad17e85b80a26c3cd98d4dc18fc5dd1"
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
