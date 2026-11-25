class Sumr < Formula
  desc "SUMR CLI"
  homepage "https://sumr.co"
  version "0.6.0"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.6.0/sumr-darwin-arm64.tar.gz"
      sha256 "6f918fd79b206a7ba86f51190e915f5a9cf75001a627d597b8e22536ffd61738"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.6.0/sumr-darwin-x64.tar.gz"
      sha256 "18db5b198b50f52d6c49e3b2ee6588cae298aec45bf8ea7d5651cd2758bd7c66"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.6.0/sumr-linux-arm64.tar.gz"
      sha256 "0c3c52e7ada426ad31f14c6ce0d8294ea2f4f0ab956d7279d933bb70f0ac7628"
    else
      url "https://github.com/SUMRco/homebrew-tap/releases/download/sumr-v0.6.0/sumr-linux-x64.tar.gz"
      sha256 "837a246bffc050c717e5d8169acab034311c0c36f234823aa2897db90b2976cb"
    end
  end

  def install
    bin.install Dir["sumr-*"][0] => "sumr"

    (bin/"_sumr_cli").write <<~SH
      #!/bin/bash
      exec "#{bin}/sumr" "$@"
    SH

    (bin/"_sumr").write <<~SH
      #!/bin/bash
      "#{bin}/_sumr_cli" "$@"
      _sumr_rc=$?
      return $_sumr_rc 2>/dev/null || exit $_sumr_rc
    SH

    chmod 0755, bin/"_sumr_cli"
    chmod 0755, bin/"_sumr"
  end

  test do
    version_output = shell_output("#{bin}/sumr --version")
    assert_match version.to_s, version_output
    assert_equal version_output, shell_output("#{bin}/_sumr_cli --version")
    assert_equal version_output, shell_output("#{bin}/_sumr --version")
    shell_output("#{bin}/_sumr sumr-formula-test-unknown-command 2>&1", 1)
  end
end
