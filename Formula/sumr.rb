class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.3.3"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.3/sumr-darwin-arm64.tar.gz"
      sha256 "6ff987e89630bb210021e1cbc1219fff23adbb22f9035b78d297a3b16975c780"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.3/sumr-darwin-x64.tar.gz"
      sha256 "90eb42b7b04eb5dc6713292f4218fceb1d2221eb0a751fe2173f99d4759149b5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.3/sumr-linux-arm64.tar.gz"
      sha256 "2b89a17c9a8246ee1224a902787683f98ae589276556cbd9f86e835a5da4c703"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.3.3/sumr-linux-x64.tar.gz"
      sha256 "42d515a03930248bb1a69c036fa7388ff11cc669ef9bf9886e6bb88182aea3f3"
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
