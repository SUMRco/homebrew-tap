class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.4.10"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.10/sumr-darwin-arm64.tar.gz"
      sha256 "94d97923655fc4ea2dc119f0cb7739fc48bebe1322f4b156a956eacdfcf27b7d"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.10/sumr-darwin-x64.tar.gz"
      sha256 "063d32f60b138080da87e8fe86457000841086c47b3797bc1e224bf58876160c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.10/sumr-linux-arm64.tar.gz"
      sha256 "15485e3f450e394f160da1fd0c59ee464727fd0acf7cdf817efa9bad2c1dc55b"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.4.10/sumr-linux-x64.tar.gz"
      sha256 "ed6e94bf010782ee5428530333e76a53052fd1de2f75bb5204d426c445f647ed"
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
